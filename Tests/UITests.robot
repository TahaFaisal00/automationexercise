*** Settings ***
Library             SeleniumLibrary
Resource            ../Resources/Common.robot
Suite Setup         Common.Launch Browser
Suite Teardown      Common.Close Browser

*** Variables ***




*** Test Cases ***

Register a New Account
    [Tags]
    Wait Until Element Is Visible    xpath=//*[@alt='Website for automation practice']
    Click link                       xpath=//*[@href='/login']
    Wait Until Page Contains         New User Signup!
    Input Text                       xpath=//*[@data-qa='signup-name' and @name='name']     Taha
    Input Text                       xpath=//*[@data-qa='signup-email' and @name='email']    taha111@gmail.com
    Click Element                    xpath=//*[@data-qa='signup-button' and text()='Signup']
    Wait Until Page Contains         Enter Account Information
    Select Radio Button              title                             Mr
    Input Text                       xpath=//*[@id='password']         taha2021
    Select From List By Label        xpath=//*[@id='days']             20
    Select From List By Label        xpath=//*[@id='months']           August
    Select From List By Label        xpath=//*[@id='years']            2000
    Select Checkbox                  xpath=//*[@type='checkbox' and @id='newsletter']
    Select Checkbox                  xpath=//input[@id='optin']
    Input Text                       xpath=//*[@id='first_name']       Taha
    Input Text                       xpath=//*[@id='last_name']        Moe
    Input Text                       xpath=//*[@id='company']          Robo
    Input Text                       xpath=//*[@id='address1']         1
    Input Text                       xpath=//*[@id='address2']         2
    Select From List By Label        xpath=//*[@id='country']          United States
    Input Text                       xpath=//*[@id='state']            NY
    Input Text                       xpath=//*[@id='city']             NY
    Input Text                       xpath=//*[@id='zipcode']          10001
    Input Text                       xpath=//*[@id='mobile_number']    71264241
    Click Element                    xpath=//*[text()='Create Account']
    Wait Until Page Contains         Account Created!
    Click Element                    xpath=//*[text()='Continue']
    Wait Until Page Contains         AutomationExercise
    Wait Until Page Contains         Category
    Wait Until Page Contains         Logged in as Taha

Login
    [Tags]
    Wait Until Element Is Visible    xpath=//*[@alt='Website for automation practice']
    Click link                       xpath=//*[@href='/login']
    Wait Until Page Contains         Login to your account
    Input Text                       xpath=//*[@data-qa='login-email' and @name='email']     taha111@gmail.com
    Input Text                       xpath=//*[@data-qa='login-password' and @name='password']    taha2021
    Click Element                    xpath=//*[text()='Login']
    Wait Until Page Contains         AutomationExercise
    Wait Until Page Contains         Category
    Wait Until Page Contains         Logged in as Taha

Login and Logout
    [Tags]
    Login
    Click Element    xpath=//*[text()='Logout']
    Wait Until Element Is Visible    xpath=//*[@alt='Website for automation practice']

Handle Ad
    Run Keyword And Ignore Error    Click Element    xpath=//











*** Keywords ***
Register a New Account
    [Tags]
    Wait Until Element Is Visible    xpath=//*[@alt='Website for automation practice']
    Click link                       xpath=//*[@href='/login']
    Wait Until Page Contains         New User Signup!
    Input Text                       xpath=//*[@data-qa='signup-name' and @name='name']     Taha

    Input Text                       xpath=//*[@data-qa='signup-name' and @name='email']    taha111@gmail.com
    Click Element                    xpath=//*[@data-qa='signup-name' and text()='Signup']
    Wait Until Page Contains         Enter Account Information
    Select Radio Button              Title                             Mr.
    Input Text                       xpath=//*[@id='password']         taha2021
    Select From List By Label        xpath=//*[@id='days']             20
    Select From List By Label        xpath=//*[@id='months']           August
    Select From List By Label        xpath=//*[@id='years']            2000
    Select Checkbox                  xpath=//*[text()='Sign up for our newsletter!']
    Select Checkbox                  xpath=//*[text()='Receive special offers from our partners!']
    Input Text                       xpath=//*[@id='first_name']       Taha
    Input Text                       xpath=//*[@id='last_name']        Moe
    Input Text                       xpath=//*[@id='company']          Robo
    Input Text                       xpath=//*[@id='address1']         1
    Input Text                       xpath=//*[@id='address2']         2
    Select From List By Label        xpath=//*[@id='country']          United States
    Input Text                       xpath=//*[@id='state']            NY
    Input Text                       xpath=//*[@id='city']             NY
    Input Text                       xpath=//*[@id='zipcode']          10001
    Input Text                       xpath=//*[@id='mobile_number']    71264241
    Click Element                    xpath=//*[text()='Create Account']
    Wait Until Page Contains         Account Created!
    Click Element                    xpath=//*[text()='Continue']
    Wait Until Page Contains         AutomationExercise
    Wait Until Page Contains         Category
    Wait Until Page Contains         Logged in as Taha

Login
    [Tags]
    Wait Until Element Is Visible    xpath=//*[@alt='Website for automation practice']
    Wait Until Element Is Visible    xpath=//*[text()='Signup / Login']
    Click Element                    xpath=//*[text()='Signup / Login']
    Wait Until Page Contains         Login to your account
    Input Text                       xpath=//*[@data-qa='login-email' and @name='email']     taha111@gmail.com
    Input Text                       xpath=//*[@data-qa='login-password' and @name='password']    taha2021
    Click Element                    xpath=//*[text()='Login']
    Wait Until Page Contains         AutomationExercise
    Wait Until Page Contains         Category
    Wait Until Page Contains         Logged in as Taha

Login and Logout
    [Tags]
    Login
    Click Element    xpath=//*[text()='Logout']
    Wait Until Element Is Visible    xpath=//*[@alt='Website for automation practice']  













