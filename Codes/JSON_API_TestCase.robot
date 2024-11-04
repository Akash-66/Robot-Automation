*** Settings ***
Library     JSONLibrary
Library     OperatingSystem
Library     Collections
Library     RequestsLibrary
Library     String
Library     base64

*** Test Cases ***
API CALL
    ${GET_MSG}  JSON API GET METHOD     #Running Keywords (function call) and storing retrun value in GET_MSG variable.
        Log    The title is ${GET_MSG}

    ${POST_MSG}  JSON API POST METHOD     #Running Keywords (function call) and storing retrun value in POST_MSG variable.
        Log    ${POST_MSG}

    ${POST_BASIC_AUTH_MSG}  JSON API BASIC AUTHORIZATION     #Running Keywords (function call) and storing retrun value in POST_BASIC_AUTH_MSG variable.
        Log    ${POST_BASIC_AUTH_MSG}

    ${POST_BEARER_AUTH_MSG}  JSON API BEARER AUTHORIZATION     #Running Keywords (function call) and storing retrun value in POST_BEARER_AUTH_MSG variable.
        Log    ${POST_BEARER_AUTH_MSG}

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
    ELSE
        ${MSG}  Set Variable    Oh no API failed :)
    END
    RETURN  ${MSG}

JSON API POST METHOD
    [Tags]    robot:continue-on-failure
    Create Session    mysession    https://thetestingworldapi.com/api    verify=True
    ${request_body}    Get File    .\\config\\api\\JSON\\StudentDetailsPost.json
    ${request_header}    Create Dictionary    Content-Type=application/json
    ${response}    POST On Session    mysession    /studentsDetails    data=${request_body}    headers=${request_header}    expected_status=any
    TRY
        Should Be Equal As Strings    ${response.status_code}    201
        ${response_content}    Set Variable    ${response.content}
        ${MSG}  Set Variable    ${response_content}
    EXCEPT
        ${MSG}  Set Variable    ${response.status_code}
    END
    RETURN  ${MSG}
    
JSON API BASIC AUTHORIZATION
    [Tags]      robot:continue-on-failure
    Create Session    mysession    https://dummyjson.com    verify=True
    ${user_credentials}    Convert To Bytes    emilys:emilyspass    #your username:your passowrd
    ${user_credentials}     Evaluate    base64.b64encode($user_credentials)     base64
    ${request_header}    Create Dictionary      Authorization=Basic ${user_credentials}    Content-Type=application/json
    ${MSG}  Set Variable    above request_header having basic authorization
    RETURN  ${MSG}

JSON API BEARER AUTHORIZATION
    [Tags]      robot:continue-on-failure
    Create Session    mysession    https://dummyjson.com    verify=True
    ${request_body}    Create Dictionary   username=emilys  password=emilyspass     expiresInMins=30
    ${request_body}     Convert Json To String    ${request_body}
    ${request_header}    Create Dictionary      Content-Type=application/json
    ${response}    POST On Session    mysession    /auth/login    data=${request_body}    headers=${request_header}    expected_status=any      #logging in to access token
    TRY
        ${response_content}    Set Variable    ${response.content}
        ${response_content}     Convert String To Json    ${response_content}
        ${token}    Get Value From Json    ${response_content}    accessToken   #storing token value for next method (GET), it will store as list value
        ${token}    Set Variable    ${token}[0]     #accesing list value and setting as a varibale
        ${request_header}    Create Dictionary      Authorization=Bearer ${token}    Content-Type=application/json      #header authorization code
        ${response}    GET On Session    mysession    /auth/me    headers=${request_header}    expected_status=any
        Should Be Equal As Strings    ${response.status_code}    200
        ${MSG}  Set Variable    ${response.status_code}
    EXCEPT
        ${MSG}  Set Variable    ${response.status_code}
    END
    RETURN  ${MSG}
