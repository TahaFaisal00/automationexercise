*** Settings ***
Library         RequestsLibrary
Resource        ../../Resources/API_RES.robot
Resource        ../../Resources/API_TestData.robot

Suite Setup     Open Session


*** Test Cases ***
POST New User Account - Valid Fields - Returns 201
    [Documentation]    Documents an API defect: a created account should return HTTP 201, but the
    ...    API returns HTTP 200. Verifies the body reports 201 with the success message.
    [Tags]    bug    api    post    positive    useraccounts
    Create Account With Retry
    # BUG: status should be 201 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Message    ${response}    ${CREATE_ACCOUNT_SUCCESS_MESSAGE}
    [Teardown]    Delete Account Via API

POST New User Account - Already Exist - Returns 400
    [Documentation]    Documents an API defect: creating an account with an already-registered email
    ...    should return HTTP 400, but the API returns HTTP 200 and reports 400 in the body.
    [Tags]    bug    api    post    negative    useraccounts
    [Setup]    Create Account With Retry
    ${response}=    Attempt Create Account With Duplicate Email Via API
    # BUG: status should be 400 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_BAD_REQUEST}
    Verify Response Message    ${response}    ${CREATE_ACCOUNT_DUPLICATE_EMAIL_MESSAGE}
    [Teardown]    Delete Account Via API

POST New User Account - Invalid Fields - Returns 201
    [Documentation]    Documents an API defect: an invalid email should be rejected with HTTP 400,
    ...    but the API accepts it and creates the account (body responseCode 201).
    [Tags]    bug    api    post    negative    useraccounts
    ${response}=    Attempt Create Account With Invalid Field Via API    ${EMAIL_FIELD}    ${INVALID_EMAIL_VALUE}
    # BUG: an invalid email should be rejected with 400, but the API accepts it and creates the account.
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_CREATED}
    Verify Response Message    ${response}    ${CREATE_ACCOUNT_SUCCESS_MESSAGE}
    [Teardown]    Delete Account Via API

POST New User Account - Missing Fields - Returns 400
    [Documentation]    Documents an API defect: creation missing a required field should return HTTP
    ...    400, but the API returns HTTP 200 and reports 400 in the body.
    [Tags]    bug    api    post    negative    useraccounts
    ${response}=    Attempt Create Account With Missing Field Via API    ${EMAIL_FIELD}
    # BUG: status should be 400 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_BAD_REQUEST}
    Verify Response Message Contains    ${response}    ${BAD_REQUEST_MESSAGE}
    Verify Response Message Contains    ${response}    ${MISSING_EMAIL_FIELD_MESSAGE}
    Verify Response Message Contains    ${response}    ${MISSING_FIELD_IN_POST_MESSAGE}

DELETE User Account - Valid Fields - Returns 200
    [Documentation]    Creates an account, deletes it, and asserts responseCode 200 with the
    ...    delete-success message.
    [Tags]    functional    api    delete    positive    useraccounts
    [Setup]    Create Account With Retry
    ${response}=    Delete Account Via API
    Verify Response Code    ${response}    ${CODE_OK}
    Verify Response Message    ${response}    ${DELETE_ACCOUNT_SUCCESS_MESSAGE}

DELETE User Account - Already Deleted - Returns 404
    [Documentation]    Documents an API defect: deleting an already-deleted account should return
    ...    HTTP 404, but the API returns HTTP 200 and reports 404 in the body.
    [Tags]    bug    api    delete    negative    useraccounts
    [Setup]    Create Account With Retry
    Delete Account Via API
    ${response}=    Delete Account Via API
    # BUG: status should be 404 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_NOT_FOUND}
    Verify Response Message    ${response}    ${ACCOUNT_NOT_FOUND_MESSAGE}

DELETE User Account - Invalid Fields - Returns 404
    [Documentation]    Documents an API defect: deleting with an email that matches no account
    ...    should return HTTP 404, but the API returns HTTP 200 and reports 404 in the body.
    [Tags]    bug    api    delete    negative    useraccounts
    [Setup]    Create Account With Retry
    ${response}=    Attempt Delete Account With Invalid Field Via API    ${EMAIL_FIELD}    ${INVALID_EMAIL_VALUE}
    # BUG: status should be 404 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_NOT_FOUND}
    Verify Response Message    ${response}    ${ACCOUNT_NOT_FOUND_MESSAGE}
    [Teardown]    Delete Account Via API

DELETE User Account - Missing Fields - Returns 400
    [Documentation]    Documents an API defect: a delete missing the required field should return
    ...    HTTP 400, but the API returns HTTP 200 and reports 400 in the body.
    [Tags]    bug    api    delete    negative    useraccounts
    [Setup]    Create Account With Retry
    ${response}=    Attempt Delete Account With Missing Field Via API    ${EMAIL_FIELD}
    # BUG: status should be 400 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_BAD_REQUEST}
    Verify Response Message Contains    ${response}    ${BAD_REQUEST_MESSAGE}
    Verify Response Message Contains    ${response}    ${MISSING_EMAIL_FIELD_MESSAGE}
    Verify Response Message Contains    ${response}    ${MISSING_FIELD_IN_DELETE_MESSAGE}
    [Teardown]    Delete Account Via API

UPDATE User Account Details - Valid Fields - Return 200
    [Documentation]    Creates an account, updates a valid field, and asserts responseCode 200
    ...    with the update-success message.
    [Tags]    functional    api    put    positive    useraccounts
    [Setup]    Create Account With Retry
    ${response}=    Update Account Via API    ${NAME_FIELD}    ${VALID_NAME_VALUE}
    Verify Response Code    ${response}    ${CODE_OK}
    Verify Response Message    ${response}    ${UPDATE_ACCOUNT_SUCCESS_MESSAGE}
    [Teardown]    Delete Account Via API

UPDATE User Account Details - Invalid Fields - Return 404
    [Documentation]    Documents an API defect: updating with an email that matches no account
    ...    should return HTTP 404, but the API returns HTTP 200 and reports 404 in the body.
    [Tags]    bug    api    put    negative    useraccounts
    [Setup]    Create Account With Retry
    ${response}=    Update Account Via API    ${EMAIL_FIELD}    ${INVALID_EMAIL_VALUE}
    # BUG: status should be 404 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_NOT_FOUND}
    Verify Response Message    ${response}    ${ACCOUNT_NOT_FOUND_MESSAGE}
    [Teardown]    Delete Account Via API

UPDATE User Account Details - Missing Fields - Return 400
    [Documentation]    Documents an API defect: an update missing the required field should return
    ...    HTTP 400, but the API returns HTTP 200 and reports 400 in the body.
    [Tags]    bug    api    put    negative    useraccounts
    [Setup]    Create Account With Retry
    ${response}=    Attempt Update Account With Missing Field Via API    ${EMAIL_FIELD}
    # BUG: status should be 400 but the API return 200. Real code is in the body.
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_BAD_REQUEST}
    Verify Response Message Contains    ${response}    ${BAD_REQUEST_MESSAGE}
    Verify Response Message Contains    ${response}    ${MISSING_EMAIL_FIELD_MESSAGE}
    Verify Response Message Contains    ${response}    ${MISSING_FIELD_IN_PUT_MESSAGE}
    [Teardown]    Delete Account Via API

GET User Details - Valid Fields - Returns 200
    [Documentation]    Creates an account, retrieves the user details, and asserts responseCode
    ...    200 with a non-empty user object.
    [Tags]    functional    api    get    positive    useraccounts
    [Setup]    Create Account With Retry
    ${response}=    Get User Details Via API
    Verify Response Code    ${response}    ${CODE_OK}
    Verify Response Field Not Empty    ${response}    ${RESPONSE_FIELD_USER}
    [Teardown]    Delete Account Via API

GET User Details - Deleted User - Returns 404
    [Documentation]    Documents an API defect: fetching details for a deleted user should return
    ...    HTTP 404, but the API returns HTTP 200 and reports 404 in the body.
    [Tags]    bug    api    get    negative    useraccounts
    [Setup]    Create Account With Retry
    Delete Account Via API
    ${response}=    Get User Details Via API
    # BUG: status should be 404 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_NOT_FOUND}
    Verify Response Message    ${response}    ${GET_ACCOUNT_NOT_FOUND_MESSAGE}

GET User Details - Invalid Fields - Returns 404
    [Documentation]    Documents an API defect: requesting details for a non-existent email should
    ...    return HTTP 404, but the API returns HTTP 200 and reports 404 in the body.
    [Tags]    bug    api    get    negative    useraccounts
    [Setup]    Create Account With Retry
    ${response}=    Attempt Get User Details With Invalid Field Via API    ${EMAIL_FIELD}    ${INVALID_EMAIL_VALUE}
    # BUG: status should be 404 but API return 200. Real code is in the body
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_NOT_FOUND}
    Verify Response Message    ${response}    ${GET_ACCOUNT_NOT_FOUND_MESSAGE}
    [Teardown]    Delete Account Via API

GET User Details - Missing Fields - Returns 400
    [Documentation]    Documents an API defect: a request missing the required field should return
    ...    HTTP 400, but the API returns HTTP 200 and reports 400 in the body.
    [Tags]    bug    api    get    negative    useraccounts
    [Setup]    Create Account With Retry
    ${response}=    Attempt Get User Details With Missing Field Via API    ${EMAIL_FIELD}
    # BUG: status should be 400 but API return 200. Real code is in the body
    Status Should Be    ${CODE_OK}    ${response}
    Verify Response Code    ${response}    ${CODE_BAD_REQUEST}
    Verify Response Message Contains    ${response}    ${BAD_REQUEST_MESSAGE}
    Verify Response Message Contains    ${response}    ${MISSING_EMAIL_FIELD_MESSAGE}
    Verify Response Message Contains    ${response}    ${MISSING_FIELD_IN_GET_MESSAGE}
    [Teardown]    Delete Account Via API
