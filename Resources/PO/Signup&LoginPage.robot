*** Settings ***
Library         SeleniumLibrary



*** Keywords ***

Enter Name to Signup New User
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@data-qa='signup-name' and @name='name']     ${credentials}

Enter Email to Signup New User
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@data-qa='signup-email' and @name='email']    ${credentials}

Click Signup Button
    Click Element                    xpath=//*[@data-qa='signup-button' and contains(normalize-space() , 'Signup')]
    Wait Until Page Contains         Enter Account Information

Choose Title
    [Arguments]                      ${credentials}
    Select Radio Button              title                             ${credentials}

Enter Password
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@id='password']         ${credentials}

Enter Day in Date of Birth
    [Arguments]                      ${credentials}
    Select From List By Label        xpath=//*[@id='days']             ${credentials}

Enter Month in Date of Birth
    [Arguments]                      ${credentials}
    Select From List By Label        xpath=//*[@id='months']           ${credentials}

Enter Year in Date of Birth
    [Arguments]                      ${credentials}
    Select From List By Label        xpath=//*[@id='years']            ${credentials}

Select Newsletter Checkbox
    Select Checkbox                  xpath=//*[@id='newsletter']

Select Partners Offers Checkbox
    Select Checkbox                  xpath=//*[@id='optin']

Enter First Name
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@id='first_name']       ${credentials}

Enter Last Name
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@id='last_name']        ${credentials}

Enter Company Name
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@id='company']          ${credentials}

Enter Address 1
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@id='address1']         ${credentials}

Enter Address 2
    [Arguments]                     ${credentials}
    Input Text                       xpath=//*[@id='address2']         ${credentials}

Enter Country
    [Arguments]                      ${credentials}
    Select From List By Label        xpath=//*[@id='country']          ${credentials}

Enter State
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@id='state']            ${credentials}

Enter City
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@id='city']             ${credentials}

Enter Zipcode
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@id='zipcode']          ${credentials}

Enter Mobile Number
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@id='mobile_number']    ${credentials}

Click Create Account Button
    Click Element                    xpath=//*[contains(normalize-space() , 'Create Account')]

Verify Account Created
    Wait Until Page Contains         Account Created!

Click Continue Button After Account Creation
    Click Element                    xpath=//*[contains(normalize-space() , 'Continue')]

Enter Email to Login
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@data-qa='login-email' and @name='email']     ${credentials}

Enter Password to Login
    [Arguments]                      ${credentials}
    Input Text                       xpath=//*[@data-qa='login-password' and @name='password']    ${credentials}

Click Login Button
    Click Element                    xpath=//*[contains(normalize-space() , 'Login')]

Invalid Credentials
    Wait Until Page Contains                            Your email or password is incorrect!

Invalid Login Error
    [Documentation]         Checks that empty fields have 'required' attribute
    [Arguments]                                   ${user}            ${url}
    IF    $user.email == ""
         ${required}     Get Element Attribute    xpath=//*[@name='email']       required
         Should Not Be Empty                      ${required}
         Location Should Be                       ${url}
    ELSE IF    $user.password == ""
         ${required}     Get Element Attribute    xpath=//*[@name='password']    required
         Should Not Be Empty                      ${required}
         Location Should Be                       ${url}
    ELSE
         Invalid Credentials
         Location Should Be                       ${url}
    END




