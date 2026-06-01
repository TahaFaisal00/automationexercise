*** Settings ***
Library         SeleniumLibrary



*** Keywords ***
Verify Signup and Login Page is Loaded
    Wait Until Page Contains         New User Signup!


Enter Name to Signup a New User
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@data-qa='signup-name' and @name='name']     ${Credentials}
Enter Email to Signup a New User
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@data-qa='signup-name' and @name='email']    ${Credentials}


Click Signup Button to Continue The Signing Up
    Click Element                    xpath=//*[@data-qa='signup-name' and text()='Signup']
Verify Signup Page is Loaded
   Wait Until Page Contains         Enter Account Information


Choose a Title
    [Arguments]                      ${Credentials}
    Select Radio Button              Title                             ${Credentials}
Enter a Password
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@id='password']         ${Credentials}
Enter a Day in the Date of Birth
    [Arguments]                      ${Credentials}
    Select From List By Label        xpath=//*[@id='days']             ${Credentials}
Enter a Month in the Date of Birth
    [Arguments]                      ${Credentials}
    Select From List By Label        xpath=//*[@id='months']           ${Credentials}
Enter a Year in the Date of Birth
    [Arguments]                      ${Credentials}
    Select From List By Label        xpath=//*[@id='years']            ${Credentials}


Click Sign up for our newsletter! Checkbox
    Select Checkbox                  xpath=//*[text()='Sign up for our newsletter!']
Click Receive special offers from our partners! Checkbox
    Select Checkbox                  xpath=//*[text()='Receive special offers from our partners!']


Enter a firstName
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@id='first_name']       ${Credentials}
Enter a lastName
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@id='last_name']        ${Credentials}
Enter a Company Name
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@id='company']          ${Credentials}
Enter Address 1
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@id='address1']         ${Credentials}
Enter Address 2
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@id='address2']         ${Credentials}
Enter a Country
    [Arguments]                      ${Credentials}
    Select From List By Label        xpath=//*[@id='country']          ${Credentials}
Enter a State
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@id='state']            ${Credentials}
Enter a City
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@id='city']             ${Credentials}
Enter a Zipcode
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@id='zipcode']          ${Credentials}
Enter Mobile Number
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@id='mobile_number']    ${Credentials}


Click Create Account Button
    Click Element                    xpath=//*[text()='Create Account']
Verify Account is Created
    Wait Until Page Contains         Account Created!
Click Continue Button
    Click Element                    xpath=//*[text()='Continue']

Enter Email to Login
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@data-qa='login-email' and @name='email']     ${Credentials}
Enter Password to Login
    [Arguments]                      ${Credentials}
    Input Text                       xpath=//*[@data-qa='login-password' and @name='password']    ${Credentials}
Click on Login Button
    Click Element                    xpath=//*[text()='Login']









