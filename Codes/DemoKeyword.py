import requests

class DemoKeyword:
    def __init__(self, *arg1, **arg2):
        print(f"sample library initialized with arg1: {arg1} and arg2: {arg2}")

    def my_first_keyword(self, *arg1, **arg2):
        return f"Keyword accepted with arguments: {arg1}"

    def JSON_API_GET_METHOD(self, url):
        response = requests.get(url)
        code_status = response.status_code
        if code_status==200:
            responseBody = response.json()
        else:
            responseBody = "Not Found"
        return responseBody
