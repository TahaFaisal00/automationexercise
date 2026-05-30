*** Settings ***
Library                                      RequestsLibrary
Library    String
Suite Setup                                  Create Session    Auto      ${Base URL}


*** Variables ***
${Base URL}                                  https://automationexercise.com

*** Test Cases ***
#name=Taha                                   email=tahaxxx@gmail.com        password=taha0
#name=DeleteMe                               email=deleteme@gmail.com        password=Delete
GET All Brands List - Returns 200
    [Tags]          functional         api     get        positive        brandslist
    ${response}     GET On Session      Auto        /api/brandsList
    Status Should Be    200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    200
    Should Not Be Empty   ${response.json()['brands']}

UPDATE to All Brands List - Returns 405
    [Tags]          bug         api     put        positive        brandslist                    #HTTP status should be 405 not 200
    ${response}     PUT On Session      Auto       /api/brandsList      expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    405
    Should Be Equal As Strings    ${response.json()['message']}    This request method is not supported.
