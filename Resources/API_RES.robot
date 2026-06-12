*** Settings ***
Library            RequestsLibrary
Library            FakerLibrary
Library    Collections
Resource           API_TestData.robot
Suite Setup          Open Session

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


Build Account Body
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
    &{body}=        Build Account Body       &{TEST_ACCOUNT}
    ${response}=        Send Create Account Request     &{body}
    RETURN      ${response}

Attempt Create Account With Invalid Field Via API
    [Documentation]     Negative-path action. Generates valid fake account data, overwrites
    ...                ${field} with ${invalid_value}, and sends the Create Account request.
    ...                This API accepts invalid values (the bug under test), so an account IS
    ...                created. The dict is published to TEST scope so the test's teardown can
    ...                delete it. Returns the raw response for the test to assert.
    [Arguments]     ${field}       ${invalid_value}
    &{account}=     Generate Fake Account Data
    Set To Dictionary       ${account}          ${field}           ${invalid_value}
    VAR         &{TEST_ACCOUNT}          &{account}         scope=TEST
    &{body}=        Build Account Body       &{TEST_ACCOUNT}
    ${response}=        Send Create Account Request     &{body}
    RETURN      ${response}

Attempt Create Account With Missing Field Via API
    [Documentation]     Negative-path action. Generates valid fake account data, then removes
    ...                ${field} to produce an incomplete body, and sends the Create Account
    ...                request. Returns the raw response for the test to assert; performs no
    ...                assertions itself. Creates no account, so no teardown is needed.
    [Arguments]     ${field}
    &{account}=     Generate Fake Account Data
    &{body}=        Build Account Body       &{account}
    Remove From Dictionary    ${body}         ${field}
    ${response}=        Send Create Account Request     &{body}
    RETURN      ${response}


Build Delete Account Body
    [Arguments]     &{account}
    &{body}=        Create Dictionary           email=${account.email}       password=${account.password}
    RETURN      &{body}

Send Delete Account Request
    [Arguments]     &{body}
    ${response}=        DELETE On Session       ${ALIAS}        ${DELETE_ACCOUNT_API}       data=${body}        expected_status=any
    RETURN      ${response}

Delete Account Via API
    [Documentation]     Fixture for [Teardown]. Deletes the newly created account by the test for cleanup.
    &{body}=        Build Delete Account Body      &{TEST_ACCOUNT}
    ${response}=     Send Delete Account Request     &{body}
    RETURN      ${response}

Attempt Delete Account With Invalid Field Via API
    [Documentation]    Negative-path action. Builds a delete body from the account created in
    ...                [Setup] (${TEST_ACCOUNT}), overwrites ${field} with ${invalid_value} on the
    ...                body only, and sends the delete request. ${TEST_ACCOUNT} is never mutated, so
    ...                the teardown keeps valid credentials to delete the real account. The delete
    ...                is expected to fail and the account persists, so the test must clean up in
    ...                teardown. Returns the raw response for the test to assert.
    [Arguments]      ${field}       ${invalid_value}
    &{body}=        Build Delete Account Body      &{TEST_ACCOUNT}
    Set To Dictionary    ${body}    ${field}        ${invalid_value}
    ${response}=     Send Delete Account Request     &{body}
    RETURN      ${response}

Attempt Delete Account With Missing Field Via API
    [Documentation]     Negative-path action. Builds a delete body from the account created in
    ...                [Setup] (${TEST_ACCOUNT}), removes ${field} so it's absent from the payload,
    ...                and sends the delete request. ${TEST_ACCOUNT} is never mutated, so the
    ...                teardown keeps valid credentials to delete the real account. The delete is
    ...                expected to fail and the account persists, so the test must clean up in
    ...                teardown. Returns the raw response for the test to assert.
    [Arguments]     ${field}
    &{body}=        Build Account Body      &{TEST_ACCOUNT}
    Remove From Dictionary    ${body}        ${field}
    ${response}=     Send Delete Account Request     &{body}
    RETURN      ${response}


Send Update Account Request
    [Arguments]     &{body}
    ${response}=     PUT On Session      ${ALIAS}            ${UPDATE_ACCOUNT_API}       data=${body}
    RETURN      ${response}

Update Account Via API
   [Documentation]      Positive-path action. Builds an account body from the [Setup]-created
    ...                account (${TEST_ACCOUNT}), overwrites ${field} with ${value} on the body
    ...                only, and sends the update. ${TEST_ACCOUNT} is never mutated, so teardown
    ...                keeps valid credentials to delete the account. Returns the raw response
    ...                for the test to assert.
   [Arguments]      ${field}        ${value}
   &{body}=        Build Account Body       &{TEST_ACCOUNT}
   Set To Dictionary    ${body}         ${field}            ${value}
   ${response}=      Send Update Account Request     &{body}
    RETURN      ${response}

Attempt Update Account With Missing Field Via API
   [Documentation]      Negative-path action. Builds an account body from the [Setup]-created
    ...                account (${TEST_ACCOUNT}), removes ${field} so it's absent from the payload,
    ...                and sends the update. ${TEST_ACCOUNT} is never mutated and the update is
    ...                expected to fail, so the account persists unchanged and the test deletes it
    ...                in teardown. Returns the raw response for the test to assert.
   [Arguments]      ${field}
   &{body}=        Build Account Body       &{TEST_ACCOUNT}
   Remove From Dictionary    ${body}         ${field}
   ${response}=      Send Update Account Request     &{body}
    RETURN      ${response}


Build Get User Params
    [Arguments]     &{account}
    &{params}=     Create Dictionary       email=${account.email}
    RETURN  ${params}

Send Get User Request
    [Arguments]     &{params}
    ${response}=        GET On Session      ${ALIAS}       ${USER_DETAIL_BY_EMAIL_API}       params=${params}
    RETURN  ${response}

Get User Details Via API
    [Documentation]     Positive-path action. Builds the query params from the [Setup]-created
    ...                account (${TEST_ACCOUNT}), sends the get-user-details request, and returns
    ...                the raw response for the test to assert. Reads only and mutates nothing;
    ...                the test still deletes the account in teardown, since GET leaves it in place.
    &{params}=      Build Get User Params       &{TEST_ACCOUNT}
    ${response}=      Send Get User Request       &{params}
    RETURN  ${response}

Attempt Get User Details With Invalid Field Via API
    [Documentation]     Negative-path action. Builds query params from the [Setup]-created account
    ...                (${TEST_ACCOUNT}), overwrites the email param with ${invalid_email}, and
    ...                sends the request. ${TEST_ACCOUNT} is never mutated; reads only, so the
    ...                account persists and the test deletes it in teardown. Returns the raw
    ...                response for the test to assert.

    [Arguments]      ${email}      ${invalid_email}
    &{params}=      Build Get User Params       &{TEST_ACCOUNT}
    Set To Dictionary    ${params}      ${email}      ${invalid_email}
    ${response}=      Send Get User Request       &{params}
    RETURN  ${response}

Attempt Get User Details With Missing Field Via API
    [Documentation]    Negative-path action. Builds query params from the [Setup]-created account
    ...                (${TEST_ACCOUNT}), removes the email param so it's absent from the query, and
    ...                sends the request. ${TEST_ACCOUNT} is never mutated; reads only, so the
    ...                account persists and the test deletes it in teardown. Returns the raw
    ...                response for the test to assert.
    [Arguments]       ${email}
    &{params}=      Build Get User Params       &{TEST_ACCOUNT}
    Remove From Dictionary    ${params}        ${email}
    ${response}=      Send Get User Request       &{params}
    RETURN  ${response}


