*** Settings ***
Library                                      RequestsLibrary
Library    String
Suite Setup                                  Create Session    Auto      ${Base URL}


*** Variables ***
${Base URL}                                  https://automationexercise.com

*** Test Cases ***
#name=Taha                                   email=tahaxxx@gmail.com        password=taha0
#name=DeleteMe                               email=deleteme@gmail.com        password=Delete
POST to Search Product - Returns 200 with Valid Required Fileds
    [Tags]          functional         api     post        positive        searchproducts
    &{body}=        Create Dictionary       search_product=shirt
    ${response}     POST On Session      Auto        /api/searchProduct     data=${body}
    Status Should Be        200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    200
    Should Not Be Empty    ${response.json()['products']}

POST to Search Product - Returns 200 with Empty Results for Invalid Required Fileds
    [Tags]          functional         api     post        negative        searchproducts
    &{body}=        Create Dictionary       search_product=xxxxxxxxx
    ${response}     POST On Session      Auto        /api/searchProduct     data=${body}        expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    200
    Should Be Empty    ${response.json()['products']}

POST to Search Product - Returns 400 with Missing Required Fileds
    [Tags]          bug         api     post        negative        searchproducts             #HTTP status should be 400 not 200
    &{body}=        Create Dictionary
    ${response}     POST On Session      Auto        /api/searchProduct     data=${body}        expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    400
    Should Be Equal As Strings    ${response.json()['message']}    Bad request, search_product parameter is missing in POST request.



















