*** Settings ***
Library                                     RequestsLibrary
Library                                     String
Resource                                    ../../Resources/API_RES.robot
Resource                                    ../../Resources/API_TestData.robot
Suite Setup                                 Open Session

*** Test Cases ***
GET Brands List - Valid Method - Returns 200
    [Documentation]     Sends a GET to the brands list endpoint and asserts the body
    ...                returns responseCode 200 with a non-empty brands list.
    [Tags]          functional         api     get        positive        brandslist
    ${response}=    Get All Brands List Via API
    Verify Response Code    ${response}     ${CODE_OK}
    Verify Response Field Not Empty    ${response}    ${RESPONSE_FIELD_BRANDS_LIST}

UPDATE Brands List - Invalid Method - Returns 405
    [Documentation]     Documents an API defect: a PUT to the brands list endpoint should
    ...                return HTTP 405, but the API returns HTTP 200 and reports 405 in
    ...                the body responseCode instead.
    [Tags]          bug         api     put        negative        brandslist
    ${response}=    Attempt Get All Brands List With Invalid Method Via API
    #BUG: status should be 405 but API returns 200. Real code is in the body
    Status Should Be    ${CODE_OK}      ${response}
    Verify Response Code    ${response}     ${CODE_METHOD_NOT_ALLOWED}
    Verify Response Message    ${response}       ${NOT_SUPPORTED_MESSAGE}
