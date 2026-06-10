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
    [Documentation]     Fixture for [Setup]. Creates a new account via API and publishes the full account dict to TEST scope for the test and teardown.
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

    VAR     &{TEST_ACCOUNT}     user_name=${fake_user_name}      email=${fake_email}      password=${fake_password}
    ...      title=${TITLE}        first_name=${fake_first_name}     last_name=${fake_second_name}      company=${fake_company}
    ...         address1=${fake_address1}        address2=${fake_address2}       country=${COUNTRY}
    ...         zipcode=${fake_zipcode}        state=${fake_state}      city=${fake_city}
    ...         mobile_number=${fake_mobile_number}      scope=TEST

    &{body}=        Create Dictionary       name=${TEST_ACCOUNT.user_name}          email=${TEST_ACCOUNT.email}
    ...     password=${TEST_ACCOUNT.password}          title=${TEST_ACCOUNT.title}       firstname=${TEST_ACCOUNT.first_name}
    ...    lastname=${TEST_ACCOUNT.last_name}       company=${TEST_ACCOUNT.company}       address1=${TEST_ACCOUNT.address1}
    ...    address2=${TEST_ACCOUNT.address2}        country=${TEST_ACCOUNT.country}      zipcode=${TEST_ACCOUNT.zipcode}
    ...      state=${TEST_ACCOUNT.state}         city=${TEST_ACCOUNT.city}          mobile_number=${TEST_ACCOUNT.mobile_number}
    ${response}=        POST On Session     ${ALIAS}          ${REGISTER_ACCOUNT_API}        data=${body}        expected_status=200
    RETURN        ${response}

Delete Account Via API
    [Documentation]     Fixture for [Teardown]. Deletes the newly created account by the test for cleanup
    &{body}=        Create Dictionary           email=${EMAIL}       password=${PASSWORD}
    ${response}=        DELETE On Session       ${ALIAS}        ${DELETE_ACCOUNT_API}       data=${body}        expected_status=any
    RETURN        ${response}


















