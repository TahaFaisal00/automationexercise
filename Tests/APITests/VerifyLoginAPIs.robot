*** Settings ***
Library                                     RequestsLibrary
Library                                     String
Resource                                    ../../Resources/API_RES.robot
Resource                                    ../../Resources/API_TestData.robot
Suite Setup                                 Open Session

*** Test Cases ***
POST Verify Login - Valid Fields - Returns 200
    [Documentation]     Creates an account, verifies login with valid credentials, and asserts
    ...                responseCode 200 with the success message.
    [Tags]          functional         api     post        positive        verifylogin
    [Setup]     Create Account With Retry
    ${response}=        Login Via API
    Verify Response Code    ${response}     ${CODE_OK}
    Verify Response Message       ${response}        ${VERIFY_LOGIN_SUCCESS_MESSAGE}
    [Teardown]  Delete Account Via API

POST Verify Login - Invalid Fields - Returns 404
    [Documentation]     Documents an API defect: login with an invalid field should return HTTP
    ...                404, but the API returns HTTP 200 and reports 404 in the body responseCode.
    [Tags]          bug         api     post        negative        verifylogin
    [Setup]     Create Account With Retry
    ${response}=        Attempt Login With Invalid Field Via API    ${EMAIL_FIELD}    ${INVALID_EMAIL_VALUE}
    # BUG: status should be 404 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}      ${response}
    Verify Response Code    ${response}          ${CODE_NOT_FOUND}
    Verify Response Message       ${response}               ${VERIFY_LOGIN_USER_NOT_FOUND_MESSAGE}
    [Teardown]  Delete Account Via API

POST Verify Login - Deleted Account - Returns 404
    [Documentation]     Documents an API defect: login against a deleted account should return HTTP
    ...                404, but the API returns HTTP 200 and reports 404 in the body responseCode.
    [Tags]          bug         api     post        negative        verifylogin
    [Setup]     Create Account With Retry
    Delete Account Via API
    ${response}=        Login Via API
    # BUG: status should be 404 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}      ${response}
    Verify Response Code     ${response}         ${CODE_NOT_FOUND}
    Verify Response Message       ${response}               ${VERIFY_LOGIN_USER_NOT_FOUND_MESSAGE}


POST Verify Login - Missing Fields - Returns 400
    [Documentation]     Documents an API defect: login missing a required field should return HTTP
    ...                400, but the API returns HTTP 200 and reports 400 in the body responseCode.
    [Tags]          bug         api     post        negative        verifylogin
    [Setup]     Create Account With Retry
    ${response}=        Attempt Login With Missing Field Via API    ${EMAIL_FIELD}
    # BUG: status should be 400 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}      ${response}
    Verify Response Code        ${response}     ${CODE_BAD_REQUEST}
    Verify Response Message Contains      ${response}            ${BAD_REQUEST_MESSAGE}
    Verify Response Message Contains      ${response}            ${VERIFY_LOGIN_MISSING_EMAIL_OR_PASSWORD_FIELD_MESSAGE}
    Verify Response Message Contains      ${response}            ${MISSING_FIELD_IN_POST_MESSAGE}
    [Teardown]  Delete Account Via API

DELETE Verify Login - Invalid Method - Returns 405
    [Documentation]     Documents an API defect: a DELETE to the verifyLogin endpoint should
    ...                return HTTP 405, but the API returns HTTP 200 and reports 405 in the
    ...                body responseCode instead.
    [Tags]              bug         api     delete        negative        verifylogin
    ${response}=        Attempt Login With Invalid Method Via API
    # BUG: status should be 405 but the api returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}      ${response}
    Verify Response Code    ${response}    ${CODE_METHOD_NOT_ALLOWED}
    Verify Response Message  ${response}  ${NOT_SUPPORTED_MESSAGE}





















