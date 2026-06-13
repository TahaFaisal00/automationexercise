*** Settings ***
Library                                     RequestsLibrary
Library                                     String
Resource                                    ../../Resources/API_RES.robot
Resource                                    ../../Resources/API_TestData.robot
Suite Setup                                 Create Session    Auto      ${BASE_URL}

*** Test Cases ***
GET Products List - Valid Method - Returns 200 and Products
    [Documentation]     Sends a GET to the products list endpoint and asserts the body
    ...                returns responseCode 200 with a non-empty products list
    [Tags]          functional         api     get        positive        productslist
    ${response}=        Get All Products List Via API
    Verify Response Code      ${response}      ${CODE_OK}
    Verify Response Field Not Empty     ${response}     ${RESPONSE_FIELD_PRODUCTS_LIST}

POST to All Products List - Returns 405
    [Tags]          bug         api     post        positive        productslist     #HTTP status should be 405 not 200
    ${response}     POST On Session      Auto        /api/productsList      expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    405
    Should Be Equal As Strings    ${response.json()['message']}    This request method is not supported.