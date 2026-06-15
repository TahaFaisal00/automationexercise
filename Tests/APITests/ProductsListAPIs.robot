*** Settings ***
Library         RequestsLibrary
Library         String
Resource        ../../Resources/API_RES.robot
Resource        ../../Resources/API_TestData.robot
Resource        ../../Resources/API_RES.robot

Suite Setup     Open Session


*** Test Cases ***
GET Products List - Valid Method - Returns 200 and Products
    [Documentation]    Sends a GET to the products list endpoint and asserts the body
    ...    returns responseCode 200 with a non-empty products list
    [Tags]    functional    api    get    positive    productslist
    ${response}=    Get All Products List Via API
    Verify Response Code    ${response}    ${CODE_OK}
    Verify Response Field Not Empty    ${response}    ${RESPONSE_FIELD_PRODUCTS_LIST}

POST Products List - Invalid Method - Returns 405
    [Documentation]    Documents an API defect: an unsupported method on the products list
    ...    endpoint should return HTTP 405, but the API returns HTTP 200 and
    ...    reports 405 in the body responseCode instead.
    [Tags]    bug    api    post    negative    productslist
    ${response}=    Attempt Get All Products List With Invalid Method Via API
    # BUG: status should be 405 but the API returns 200. Real code is in the body
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_METHOD_NOT_ALLOWED}
    Verify Response Message    ${response}    ${NOT_SUPPORTED_MESSAGE}
