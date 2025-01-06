*** Settings ***
Library     Selenium2Library


*** Test Cases ***
Open_Web_Browser
    [Setup]     Open Browser    https://github.com/Akash-66     chrome
    [Teardown]      Close Browser
    Click Element    //*[contains(text(), "Ev-system") and @class="repo"]
    Wait Until Element Is Visible    //*[contains(text(), "Code")and @class="prc-Button-Label-pTQ3x"]

Data_Dependednt_browser_TestCase
    [Template]  Data_Dependednt_browser
    https://github.com/Akash-66
    https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html
    https://docs.robotframework.org/docs/extending_robot_framework/custom-libraries/python_library


*** Keywords ***
Data_Dependednt_browser
    [Arguments]     ${browser_link}
    Open Browser    ${browser_link}     chrome
    Close Browser


