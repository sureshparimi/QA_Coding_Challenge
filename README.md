<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://i.imgur.com/FxL5qM0.jpg" alt="Bot logo"></a>
</p>

<h3 align="center">Project Title</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![Platform](https://img.shields.io/badge/platform-reddit-orange.svg)](https://www.reddit.com/user/Wordbook_Bot)
[![GitHub Issues](https://img.shields.io/github/issues/kylelobo/The-Documentation-Compendium.svg)](https://github.com/kylelobo/The-Documentation-Compendium/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/kylelobo/The-Documentation-Compendium.svg)](https://github.com/kylelobo/The-Documentation-Compendium/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> 🤖 Few lines describing what your bot does.
    <br> 
</p>

## 📝 Table of Contents

- [About](#about)
- [Make it work](#working)
- [Robot Framework Tests](#RobotframeworkTests)
- [Jmeter Tests](#JmeterTests)

## 🧐 About <a name = "about"></a>

The project is about solving the a QA challenge of API testing using Robot Framework and Jmeter 


## 💭 Make it work <a name = "working"></a>

Clone the repository. 
Install dependencies such as Pycharm or VS Code, Robot Framework, Flask, robotframework-jsonschema, robotframework-requestLibrary etc

## 🎈 Robot Framework Tests <a name = "RobotFrameworkTests"></a>
Once installed, you will be able to run all the tests or individual tests uring robot command from terminal
 For example, to run, all the tests, use the command "robot ."


## 🎈 Jmeter Tests
Make sure both the FlaskServer.py and .jmx file  are located under bin folder of jmeter on your local machine 
Go to CLI and run the below command to display the summary of the test in the terminal
"jmeter -n -t 0602_JmeterTestPlan.jmx -l result.jtl && D:\jmeter\bin\jmeter -g result.jtl -o report"

After the test ran, a folder with Report will be generated in the bin folder. You can review the test results using the .html file in the report folder.

Note: Beanshell scripts are added to .jmx file, make sure they are available when you clone the .jmx file.

