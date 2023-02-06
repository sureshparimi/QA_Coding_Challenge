<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://i.imgur.com/FxL5qM0.jpg" alt="Bot logo"></a>
</p>

<h3 align="center">QA Coding Challenge</h3>

<div align="center">

[![Linkedin](https://linkedin.com/in/sparimi)](https://charming-pegasus-ec3f3f.netlify.app/)
[![Portfolio](https://charming-pegasus-ec3f3f.netlify.app/)](https://charming-pegasus-ec3f3f.netlify.app/)
</div>

---

<p align="center"> 🤖 Few lines about the Project
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


