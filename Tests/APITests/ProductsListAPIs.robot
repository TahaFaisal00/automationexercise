*** Settings ***
Library                                     RequestsLibrary
Library                                     String
Resource                                    ../../Resources/API_RES.robot
Resource                                    ../../Resources/TestData.robot
Suite Setup                                 Create Session    Auto      ${BASE_URL}


*** Test Cases ***
#name=Taha                                   email=tahaxxx@gmail.com        password=taha0
#name=DeleteMe                               email=deleteme@gmail.com        password=Delete

GET All Products List - Returns 200
    [Tags]          functional         api     get        positive        productslist
    ${response}     GET On Session      Auto        /api/productsList
    Status Should Be    200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    200
    Should Not Be Empty    ${response.json()['products']}


POST to All Products List - Returns 405
    [Tags]          bug         api     post        positive        productslist     #HTTP status should be 405 not 200
    ${response}     POST On Session      Auto        /api/productsList      expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    405
    Should Be Equal As Strings    ${response.json()['message']}    This request method is not supported.