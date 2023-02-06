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
TestCase-1: Validates the response JSON schema for the people endpoint
    [Documentation]    Validates the response JSON schema for the people endpoint
    [Tags]             people_end_point    smoketest
    ${schema}    Get Binary File    \\PythonProjects\\Tests\\TestData\\default_person_schema.json
    # Load the string as a binary object, you could then use this like ${schema}[someProperty] if you wanted to
    ${people_schema}    evaluate    json.loads('''${schema}''')    json
    Log     ${people_schema}
    Create Session     people_endpoint     ${BASE_ENDPOINT}
    ${response_people}=  GET On Session  people_endpoint  /people/${People_test_data['person_test_data'][0]['id']}
    Should Be Equal As Strings          ${response_people.status_code}  200
    Should Be Equal As Strings          ${response_people.reason}  OK
    #jsonschema Should match ${response_people.content} ${people_schema}
    Evaluate    jsonschema.validate(instance=${response_people.content}, schema=${people_schema})

Test Case 2: Validate response with valid people ID and name
    Create Session    people_api    ${BASE_ENDPOINT}
    ${response_people}=  GET On Session  people_api  /people/${People_test_data['person_test_data'][1]['id']}
    ${json_response}=    Set Variable    ${response_people.json()}
    Should Be Equal As Strings     ${json_response[0]["name"]}   ${People_test_data['person_test_data'][1]['name']}  
    Should Be Equal As Strings    ${response_people.status_code}    200

Test Case 3: Validate response with non-existent people ID
    Create Session    people_api    ${BASE_ENDPOINT}
    ${response_people}=  GET On Session  people_api  /people/${People_test_data['person_test_data'][3]['id']}    expected_status=404
    ${json_response}=    Set Variable    ${response_people.json()}
    Log    ${json_response["error"]}
    Should Be Equal As Strings    ${response_people.status_code}    404
    Should Contain    ${json_response["error"]}   Person not found with id
    Should Contain    ${json_response["error"]}   Please try with ids less than 100

Test Case 4: Validate response with negative people ID
    Create Session    people_api    ${BASE_ENDPOINT}
    ${response_people}=  GET On Session  people_api  /people/${People_test_data['person_test_data'][5]['id']}   expected_status=404
    ${json_response}=    Set Variable    ${response_people.text}
    Should Be Equal As Strings    ${response_people.status_code}    404
    Should Contain    ${json_response}    The requested URL was not found on the server. If you entered the URL manually please check your spelling and try again.

Test Case 5: Validate response with large people ID
    Create Session    people_api    ${BASE_ENDPOINT}
    ${response_people}=  GET On Session  people_api  /people/${people_test_data['person_test_data'][4]['id']}   expected_status=404
    ${json_response}=    Set Variable    ${response_people.json()}
    Should Be Equal As Strings    ${response_people.status_code}    404
    Should Contain    ${json_response["error"]}   Person not found with id
    Should Contain    ${json_response["error"]}   Please try with ids less than 100


Test Case 6: Validate response with string people ID
    Create Session    people_api    ${BASE_ENDPOINT}
    ${response_people}=  GET On Session  people_api  /people/${People_test_data['person_test_data'][6]['id']}     expected_status=404
    ${json_response}=    Set Variable    ${response_people.text}
    Should Be Equal As Strings    ${response_people.status_code}    404
    Should Contain    ${json_response}    The requested URL was not found on the server. If you entered the URL manually please check your spelling and try again.


*** Keywords ***
Start the server
    ${Falsk_server_state}=    start_flask_server
    Set Suite Variable    ${Falsk_server_state}
    ${People_test_data}=    load json from file   ${EXECDIR}\\Tests\\TestData\\person_TestData.json
    # ${json_data}=    Evaluate    json.loads(${People_test_data})
    Set Suite Variable    ${People_test_data}
    ${Starships_test_data}=    load json from file   ${EXECDIR}\\Tests\\TestData\\starships_testData.json
    # ${json_data}=    Evaluate    json.loads(${People_test_data})
    Set Suite Variable    ${Starships_test_data}

Shutdown the Server
    stop_flask_server    ${Falsk_server_state}
    Log        "The server is shutdown"
    


 
  

