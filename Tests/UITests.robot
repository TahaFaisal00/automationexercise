*** Settings ***
Library                              SeleniumLibrary
Resource                             ../Resources/Common.robot
Resource                             ../Resources/automationexerciseRes.robot
Suite Setup                          Common.Launch Browser
Suite Teardown                       Common.Close Browser

*** Test Cases ***
Login and Logout
    [Tags]
    Login                 ${MAIN USER}
    Logout                ${MAIN USER}























Handle Ad
    Run Keyword And Ignore Error     Click Element    xpath=//


























