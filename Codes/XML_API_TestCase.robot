*** Settings ***
Library           RequestsLibrary
Library           XML
Library           OperatingSystem
Library           Collections

*** Test Cases ***
API CALL
    ${GET_MSG}  SOAP API GET METHOD     #Running Keywords (function call) and storing retrun value in GET_MSG variable.
        Log    ${GET_MSG}

    ${POST_MSG}  SOAP API POST METHOD     #Running Keywords (function call) and storing retrun value in POST_MSG variable.
        Log    ${POST_MSG}

*** Keywords ***

SOAP API POST METHOD
    [Tags]    robot:continue-on-failure
    ${request_xml}    Get File    .\\config\\api\\XML\\StudentDetailsPost.xml
    Create Session    mysession    https://thetestingworldapi.com/api    verify=true
    ${request_header}    Create Dictionary    Content-Type=application/xml
    ${response}    POST On Session    mysession    /studentsDetails    data=${request_xml}    headers=${request_header}    expected_status=any
    #${response_status}    Set Variable    ${response}    # response will return status only
    TRY
        Should Be Equal As Strings    ${response.status_code}    201
        ${response_content}    Set Variable    ${response.content}
        ${MSG}  Set Variable    ${response_content}
    EXCEPT
        ${MSG}  Set Variable    ${response.status_code}
    END
    RETURN  ${MSG}

SOAP API GET METHOD
    [Tags]    robot:continue-on-failure
    Create Session    mysession    https://thetestingworldapi.com/api    verify=true
    ${response}    GET On Session    mysession    /studentsDetails
    ${response_status}    Set Variable    ${response}    # response will return status only
    TRY
        Should Be Equal As Strings    ${response.status_code}    200
        ${MSG}  Set Variable    ${response.status_code}
    EXCEPT
        ${MSG}  Set Variable    ${response.status_code}
    END
    RETURN  ${MSG}