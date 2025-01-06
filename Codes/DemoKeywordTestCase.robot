*** Settings ***
Library     DemoKeyword.py

*** Test Cases ***
DEMOKEYWORD_FIRST_KEYWORD
    ${data}     My First Keyword    Akash   Kesarwani
    Log To Console    ${data}
DEMOKEYWORD_API_GET_METHOD
    ${response_api}     JSON API GET METHOD     https://jsonplaceholder.typicode.com/todos/1
    Log    ${response_api}