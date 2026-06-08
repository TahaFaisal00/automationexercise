*** Settings ***
Library     RequestsLibrary
Library     FakerLibrary

Suite Setup          Open Session
*** Variables ***
${BASE_URL}                                  https://automationexercise.com
${ALIAS}          Auto
${REGISTER_ACCOUNT_API}         /api/createAccount
${DELETE_ACCOUNT_API}           /api/deleteAccount

*** Keywords ***
Open Session
    [Documentation]     Opens the shared HTTP session used be all tests
    Create Session        ${ALIAS}       ${BASE_URL}

Create Account Via API
    [Documentation]     Fixture for [Setup]. Created a new account and turn the login creds to TEST scope for test case and test teardown
    ${fake_user_name}=                       FakerLibrary.Name
    ${fake_email}=                           FakerLibrary.Email
    ${fake_password}=                        FakerLibrary.Password
    ${fake_others}=                          FakerLibrary.Word
    ${fake_others_numbers}=                  FakerLibrary.Random Number
    VAR            ${USER_NAME}              ${fake_user_name}               scope=TEST
    VAR            ${EMAIL}                  ${fake_email}                   scope=TEST
    VAR            ${PASSWORD}               ${fake_password}                scope=TEST
    VAR            ${OTHER_DETAILS}          ${fake_others}
    VAR            ${OTHER_NUMBERS}          ${fake_others_numbers}

    &{body}=        Create Dictionary       name=${USER_NAME}          email=${EMAIL}        password=${PASSWORD}         title=${OTHER_DETAILS}       firstname=${OTHER_DETAILS}       lastname=${OTHER_DETAILS}      address1=${OTHER_DETAILS}       country=${OTHER_DETAILS}     state=${OTHER_DETAILS}     city=${OTHER_DETAILS}       zipcode=${OTHER_NUMBERS}        mobile_number=${OTHER_NUMBERS}
    ${response}=        POST On Session     $${ALIAS}          ${REGISTER_ACCOUNT_API}        data=${body}        expected_status=200
    RETURN        ${response}

Delete Account Via API
    [Documentation]     Fixture for [Teardown]. Deletes the newly created account by the test for cleanup
    &{body}=        Create Dictionary           email=${EMAIL}       password=${PASSWORD}
    ${response}=        DELETE On Session       ${ALIAS}        ${DELETE_ACCOUNT_API}       data=${body}        expected_status=200
    RETURN        ${response}


















