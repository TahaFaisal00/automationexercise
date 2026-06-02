*** Settings ***
Library                              SeleniumLibrary
Resource                             ../Resources/Common.robot
Resource                             ../Resources/automationexerciseRes.robot
Suite Setup                          Common.Launch Browser
Suite Teardown                       Common.Close Browser

*** Test Cases ***
Login and Logout
    [Tags]
    Login                             ${MAIN USER}
    Logout                            ${MAIN USER}

Delete an Account
    [Tags]
    Register a New Account            ${DELETED USER}    ${DATE OF BIRTH}    ${SIGNUP DETAILS}
    Delete Account                    ${DELETED USER}

Login With Invalid Credential
    [Tags]
    [Template]             automationexerciseRes.Invalid Credentials
    ${USER EMPTY EMAIL}
    ${USER EMPTY PASSWORD}
    ${DELETED USER}






Handle Ad
    Run Keyword And Ignore Error     Click Element    xpath=//


























