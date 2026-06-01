*** Settings ***
Library         SeleniumLibrary



*** Keywords ***
Verify Home Page is Loaded
    Wait Until Element Is Visible    xpath=//*[@alt='Website for automation practice']
    Wait Until Page Contains         Category

Click on Signup and Login
    Click link                       xpath=//*[@href='/login']
    Wait Until Page Contains         Login to your account
Verify Account Signed in Successfully
    [Arguments]             ${User}
    Wait Until Page Contains         Logged in as ${User}














