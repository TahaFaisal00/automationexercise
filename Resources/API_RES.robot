*** Settings ***
Library     RequestsLibrary
Library     FakerLibrary

Suite Setup          Open Session
*** Variables ***
${BASE_URL}                                  https://automationexercise.com
${ALIAS}          Auto
${REGISTER_ACCOUNT_API}         /api/createAccount
${DELETE_ACCOUNT_API}           /api/deleteAccount
${COUNTRY}                  Test
${TITLE}                    Mr
*** Keywords ***
Open Session
    [Documentation]     Opens the shared HTTP session used be all tests
    Create Session        ${ALIAS}       ${BASE_URL}

Generate Fake Account Data
    [Documentation]     Creates all the account details using the FakerLibrary.
    ${fake_user_name}=                       FakerLibrary.Name
    ${fake_email}=                           FakerLibrary.Email
    ${fake_password}=                        FakerLibrary.Password
    ${fake_first_name}=                      FakerLibrary.First Name Male
    ${fake_second_name}=                     FakerLibrary.Last Name Male
    ${fake_company}=                         FakerLibrary.Company
    ${fake_address1}=                        FakerLibrary.Street Address
    ${fake_address2}=                        FakerLibrary.Secondary Address
    ${fake_zipcode}=                         FakerLibrary.Zipcode
    ${fake_state}=                           FakerLibrary.State
    ${fake_city}=                            FakerLibrary.City
    ${fake_mobile_number}=                   FakerLibrary.Basic Phone Number

    VAR     &{account}     user_name=${fake_user_name}      email=${fake_email}      password=${fake_password}
    ...      title=${TITLE}        first_name=${fake_first_name}     last_name=${fake_second_name}      company=${fake_company}
    ...         address1=${fake_address1}        address2=${fake_address2}       country=${COUNTRY}
    ...         zipcode=${fake_zipcode}        state=${fake_state}      city=${fake_city}
    ...         mobile_number=${fake_mobile_number}
    RETURN      &{account}

Build Create Account body
    [Arguments]     ${account}
    &{body}=        Create Dictionary       name=${account.user_name}          email=${account.email}
    ...     password=${account.password}          title=${account.title}       firstname=${account.first_name}
    ...    lastname=${account.last_name}       company=${account.company}       address1=${account.address1}
    ...    address2=${account.address2}        country=${account.country}      zipcode=${account.zipcode}
    ...      state=${account.state}         city=${account.city}          mobile_number=${account.mobile_number}
    RETURN      &{body}

Send Create Account Request
    [Arguments]     &{body}
    ${response}=        POST On Session     ${ALIAS}          ${REGISTER_ACCOUNT_API}        data=${body}
    RETURN      ${response}

Create Account Via API
    [Documentation]     Fixture for [Setup]. Creates a new account via API and publishes the full account dict to TEST scope for the test and teardown.
    &{account}=     Generate Fake Account Data
    VAR         &{TEST_ACCOUNT}          &{account}         scope=TEST
    &{body}=        Build Create Account body       &{TEST_ACCOUNT}
    ${response}=        Send Create Account Request     &{body}
    RETURN      ${response}



Delete Account Via API
    [Documentation]     Fixture for [Teardown]. Deletes the newly created account by the test for cleanup
    &{body}=        Create Dictionary           email=${TEST_ACCOUNT.email}       password=${TEST_ACCOUNT.password}
    ${response}=        DELETE On Session       ${ALIAS}        ${DELETE_ACCOUNT_API}       data=${body}        expected_status=any
    RETURN        ${response}


















