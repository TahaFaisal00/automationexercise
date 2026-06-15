*** Settings ***
Library         RequestsLibrary
Library         String
Resource        ../../Resources/API_RES.robot
Resource        ../../Resources/API_TestData.robot

Suite Setup     Open Session


*** Test Cases ***
POST Search Product - Valid Fields - Returns 200
    [Documentation]    Searches for an existing product and asserts the API returns
    ...    responseCode 200 with a non-empty products list.
    [Tags]    functional    api    post    positive    searchproducts
    ${response}=    Search Product Via API    ${SHIRT}
    Verify Response Code    ${response}    ${CODE_OK}
    Verify Response Field Not Empty    ${response}    ${RESPONSE_FIELD_PRODUCTS_LIST}

POST Search Product - Invalid Fields - Returns 200 with Empty Results
    [Documentation]    Searches for a term with no matches and asserts the API returns
    ...    responseCode 200 with an empty products list.
    [Tags]    functional    api    post    positive    searchproducts
    ${response}=    Search Product Via API    ${NON_EXISTENT_PRODUCT}
    Verify Response Code    ${response}    ${CODE_OK}
    Verify Response Products Empty    ${response}

POST Search Product - Missing Fields - Returns 400
    [Documentation]    Documents an API defect: a search missing the required field should
    ...    return HTTP 400, but the API returns HTTP 200 and reports 400 in the
    ...    body responseCode instead.
    [Tags]    bug    api    post    negative    searchproducts
    ${response}=    Attempt Search Product With Missing Field Via API    ${SHIRT}    ${SEARCH_FIELD}
    # BUG: transport status should be 400 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_BAD_REQUEST}
    Verify Response Message Contains    ${response}    ${BAD_REQUEST_MESSAGE}
    Verify Response Message Contains    ${response}    ${SEARCH_PRODUCT_MISSING_FIELD_MESSAGE}
    Verify Response Message Contains    ${response}    ${MISSING_FIELD_IN_POST_MESSAGE}
