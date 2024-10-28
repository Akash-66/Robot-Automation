*** Settings ***
Library     JSONLibrary
Library     OperatingSystem
Library     Collections
Library     RequestsLibrary
Library     String

*** Test Cases ***
API CALL
    ${MSG}  JSON API GET METHOD     #Running Keywords (function call) and storing retrun value in MSG variable.
    Log    The title is ${MSG}

*** Keywords ***
JSON API GET METHOD
    [Tags]    robot:continue-on-failure
    Create Session    mysession    https://jsonplaceholder.typicode.com    verify=True
    ${response}    GET On Session    mysession    /todos/1    expected_status=any
    ${response_status}    Set Variable    ${response.status_code}
    Log To Console    ${response_status}
    IF    $response_status==200
        ${response_content}    Set Variable    ${response.content}
        ${response_content}    Convert String To Json    ${response_content}
        ${Title}    Get Value From Json    ${response_content}    title
        ${MSG}  Set Variable    ${Title}
        Log To Console    ${MSG}
    ELSE
        ${MSG}  Set Variable    Oh no API failed :)
        Log To Console    ${MSG}
    END
    RETURN  ${MSG}