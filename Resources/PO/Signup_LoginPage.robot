*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${NAME_SIGNUP_FIELD}            css=[data-qa='signup-name']
${EMAIL_SIGNUP_FIELD}           css=[data-qa='signup-email']
${SIGNUP_BUTTON}                css=[data-qa='signup-button']

${SIGNUP_NAME_SIGNUP_PAGE}                  css=[data-qa='name']
${SIGNUP_EMAIL_SIGNUP_PAGE}                 css=[data-qa='email']

${PASSWORD_SIGNUP_FIELD}        id=password
${DAY_DOB_SIGNUP_FIELD}         id=days
${MONTH_DOB_SIGNUP_FIELD}       id=months
${YEAR_DOB_SIGNUP_FIELD}        id=years
${NEWSLETTER_SIGNUP_CHECKBOX}        id=newsletter
${PARTNER_OFFERS_SIGNUP_CHECKBOX}       id=optin
${FIRST_NAME_SIGNUP_FIELD}      id=first_name
${LAST_NAME_SIGNUP_FIELD}       id=last_name
${COMPANY_SIGNUP_FIELD}         id=company
${ADDRESS_1_SIGNUP_FIELD}       id=address1
${ADDRESS_2_SIGNUP_FIELD}       id=address2
${COUNTRY_SIGNUP_FIELD}         id=country
${STATE_SIGNUP_FIELD}           id=state
${CITY_SIGNUP_FIELD}            id=city
${ZIPCODE_SIGNUP_FIELD}         id=zipcode
${MOBILE_NUMBER_SIGNUP_FIELD}       id=mobile_number
${CREATE_ACCOUNT_BUTTON}           css=[data-qa='create-account']
${CONTINUE_BUTTON_AFTER_ACCOUNT_CREATION}          css=[data-qa='continue-button']

${EMAIL_LOGIN_FIELD}        css=[data-qa='login-email']
${PASSWORD_LOGIN_FIELD}     css=[data-qa='login-password']
${LOGIN_BUTTON}             css=[data-qa='login-button']

${SIGNUP_LOGIN_PAGE_URL}        https://automationexercise.com/login
${SIGNUP_PAGE_URL}              https://automationexercise.com/signup
${ACCOUNT_CREATED_URL}          https://automationexercise.com/account_created
*** Keywords ***
Verify Signup Login Page Loaded
    Wait Until Page Contains    New User Signup!
    Location Should Be          ${SIGNUP_LOGIN_PAGE_URL}

Enter Name To Signup New User
    [Arguments]                      ${user_name}
    Input Text                       ${NAME_SIGNUP_FIELD}     ${user_name}

Enter Email To Signup New User
    [Arguments]                      ${email}
    Input Text                       ${EMAIL_SIGNUP_FIELD}    ${email}

Click Signup Button
    Click Element                    ${SIGNUP_BUTTON}
    Wait Until Page Contains         Enter Account Information

Verify Signup Page Loaded
    [Arguments]                 ${user_name}            ${email}
    Wait Until Page Contains    Enter Account Information
    Location Should Be          ${SIGNUP_PAGE_URL}
    ${actual_signup_name}=      Get Text    ${SIGNUP_NAME_SIGNUP_PAGE}
    Should Be Equal As Strings    ${actual_signup_name}    ${user_name}
    ${actual_signup_email}=      Get Text    ${SIGNUP_EMAIL_SIGNUP_PAGE}
    Should Be Equal As Strings    ${actual_signup_name}    ${email}

Choose Title
    [Arguments]                      ${title}
    Select Radio Button              title                             ${title}

Enter Password
    [Arguments]                      ${password}
    Input Text                       ${PASSWORD_SIGNUP_FIELD}         ${password}

Select Day In Date Of Birth
    [Arguments]                      ${day_dob}
    Select From List By Label        ${DAY_DOB_SIGNUP_FIELD}             ${day_dob}

Select Month In Date Of Birth
    [Arguments]                      ${month_dob}
    Select From List By Label        ${MONTH_DOB_SIGNUP_FIELD}          ${month_dob}

Select Year In Date Of Birth
    [Arguments]                      ${year_dob}
    Select From List By Label        ${YEAR_DOB_SIGNUP_FIELD}            ${year_dob}

Select Newsletter Checkbox
    Select Checkbox                  ${NEWSLETTER_SIGNUP_CHECKBOX}

Select Partners Offers Checkbox
    Select Checkbox                  ${PARTNER_OFFERS_SIGNUP_CHECKBOX}

Enter First Name
    [Arguments]                      ${first_name}
    Input Text                       ${FIRST_NAME_SIGNUP_FIELD}      ${first_name}

Enter Last Name
    [Arguments]                      ${last_name}
    Input Text                       ${LAST_NAME_SIGNUP_FIELD}        ${last_name}

Enter Company Name
    [Arguments]                      ${company}
    Input Text                       ${COMPANY_SIGNUP_FIELD}          ${company}

Enter Address 1
    [Arguments]                      ${address_1}
    Input Text                       ${ADDRESS_1_SIGNUP_FIELD}         ${address_1}

Enter Address 2
    [Arguments]                      ${address_2}
    Input Text                       ${ADDRESS_2_SIGNUP_FIELD}         ${address_2}

Select Country
    [Arguments]                      ${country}
    Select From List By Label        ${COUNTRY_SIGNUP_FIELD}          ${country}

Enter State
    [Arguments]                      ${state}
    Input Text                       ${STATE_SIGNUP_FIELD}            ${state}

Enter City
    [Arguments]                      ${city}
    Input Text                       ${CITY_SIGNUP_FIELD}             ${city}

Enter Zipcode
    [Arguments]                      ${zipcode}
    Input Text                       ${ZIPCODE_SIGNUP_FIELD}           ${zipcode}

Enter Mobile Number
    [Arguments]                      ${mobile_number}
    Input Text                       ${MOBILE_NUMBER_SIGNUP_FIELD}    ${mobile_number}

Click Create Account Button
    Click Element                    ${CREATE_ACCOUNT_BUTTON}

Verify Account Created
    Wait Until Page Contains         Account Created!
    Location Should Be               ${ACCOUNT_CREATED_URL}

Click Continue Button After Account Creation
    Click Element                    ${CONTINUE_BUTTON_AFTER_ACCOUNT_CREATION}

Enter Email To Login
    [Arguments]                      ${email}
    Input Text                       ${EMAIL_LOGIN_FIELD}     ${email}

Enter Password To Login
    [Arguments]                      ${password}
    Input Text                       ${PASSWORD_LOGIN_FIELD}    ${password}

Click Login Button
    Click Element                    ${LOGIN_BUTTON}

Verify Invalid Credentials Error
    Wait Until Page Contains                            Your email or password is incorrect!

Invalid Login Error
    [Documentation]         Checks that empty fields have 'required' attribute and Error Message
    [Arguments]                                   ${user_email}      ${user_password}         ${url}
    IF    $user_email == ""
         ${required}     Get Element Attribute    ${EMAIL_LOGIN_FIELD}       required
         Should Not Be Empty                      ${required}
         Location Should Be                       ${url}
    ELSE IF    $user_password == ""
         ${required}     Get Element Attribute    ${PASSWORD_LOGIN_FIELD}    required
         Should Not Be Empty                      ${required}
         Location Should Be                       ${url}
    ELSE
         Verify Invalid Credentials Error
         Location Should Be                       ${url}
    END




