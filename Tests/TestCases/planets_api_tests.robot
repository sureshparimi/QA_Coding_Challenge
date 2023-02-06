*** Settings ***
Library     OperatingSystem
Library    jsonschema
Library    RequestsLibrary
Library    JSONLibrary
Library    ..\\Resources\\RunTheServer.py
Suite Setup        Start the server
Suite Teardown     Shutdown the Server


*** Variables ***
${BASE_ENDPOINT}  http://localhost:5008

   

*** Test Cases ***
TestCase-1: Validates the response JSON schema for the planets endpoint
    [Documentation]    Validates the response JSON schema for the planets endpoint
    [Tags]             planet_end_point    smoketest
    ${schema}    Get Binary File    \\PythonProjects\\Tests\\TestData\\default_planet_schema.json
    # Load the string as a binary object, you could then use this like ${schema}[someProperty] if you wanted to
    ${planet_schema}    evaluate    json.loads('''${schema}''')    json
    Log     ${planet_schema}
    Create Session     planet_end_point     ${BASE_ENDPOINT}
    ${response_planets}=  GET On Session  planet_end_point  /planets/${Planets_test_data['planets_test_data'][0]['id']}
    Should Be Equal As Strings          ${response_planets.status_code}  200
    Should Be Equal As Strings          ${response_planets.reason}  OK
    #jsonschema Should match ${response_planets.content} ${planets_schema}
    Evaluate    jsonschema.validate(instance=${response_planets.content}, schema=${planet_schema})

Test Case 2: Validate response with valid planets ID and name
    Create Session    planet_end_point    ${BASE_ENDPOINT}
    ${response_planets}=  GET On Session  planet_end_point  /planets/${Planets_test_data['planets_test_data'][1]['id']}
    ${json_response}=    Set Variable    ${response_planets.json()}
    Log    ${json_response}
    Should Be Equal As Strings     ${json_response["name"]}   ${Planets_test_data['planets_test_data'][1]['name']}
    Should Be Equal As Strings    ${response_planets.status_code}    200

Test Case 3: Validate response with non-existent planets ID
    Create Session    planets_api    ${BASE_ENDPOINT}
    ${response_planets}=  GET On Session  planets_api  /planets/${Planets_test_data['planets_test_data'][3]['id']}    expected_status=404
    ${json_response}=    Set Variable    ${response_planets.json()}
    Log    ${json_response["error"]}
    Should Be Equal As Strings    ${response_planets.status_code}    404
    Should Contain    ${json_response["error"]}   planet not found with id
    Should Contain    ${json_response["error"]}   Please try with ids less than 100

Test Case 4: Validate response with negative planets ID
    Create Session    planets_api    ${BASE_ENDPOINT}
    ${response_planets}=  GET On Session  planets_api  /planets/${Planets_test_data['planets_test_data'][5]['id']}   expected_status=404
    ${json_response}=    Set Variable    ${response_planets.text}
    Should Be Equal As Strings    ${response_planets.status_code}    404
    Should Contain    ${json_response}    The requested URL was not found on the server. If you entered the URL manually please check your spelling and try again.

Test Case 5: Validate response with large planets ID
    Create Session    planets_api    ${BASE_ENDPOINT}
    ${response_planets}=  GET On Session  planets_api  /planets/${Planets_test_data['planets_test_data'][4]['id']}   expected_status=404
    ${json_response}=    Set Variable    ${response_planets.json()}
    Should Be Equal As Strings    ${response_planets.status_code}    404
    Should Contain    ${json_response["error"]}   planet not found with id
    Should Contain    ${json_response["error"]}   Please try with ids less than 100


Test Case 6: Validate response with string planets ID
    Create Session    planets_api    ${BASE_ENDPOINT}
    ${response_planets}=  GET On Session  planets_api  /planets/${Planets_test_data['planets_test_data'][6]['id']}     expected_status=404
    ${json_response}=    Set Variable    ${response_planets.text}
    Should Be Equal As Strings    ${response_planets.status_code}    404
    Should Contain    ${json_response}    The requested URL was not found on the server. If you entered the URL manually please check your spelling and try again.


*** Keywords ***
Start the server
    ${Flask_server_state}=    start_flask_server
    Set Suite Variable    ${Flask_server_state}
    ${Planets_test_data}=    load json from file   ${EXECDIR}\\Tests\\TestData\\planets_testData.json
    # ${json_data}=    Evaluate    json.loads(${Planets_test_data})
    Set Suite Variable    ${Planets_test_data}

Shutdown the Server
    stop_flask_server    ${Flask_server_state}
    Log        "The server is shutdown"
