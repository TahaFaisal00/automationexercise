*** Settings ***
Library                 SeleniumLibrary

*** Variables ***
${BROWSER}              chrome
${URL}                  https://automationexercise.com/
${WINDOWSWIDTH}         1280
${WINDOWSHEIGHT}        1024
${IMPLICITWAIT}         10s
${SELENUIMSPEED}        0

*** Keywords ***
Launch Browser
    Open Browser           ${URL}      ${BROWSER}
    Set Window Size       ${WINDOWSWIDTH}    ${WINDOWSHEIGHT}
    Set Selenium Implicit Wait    ${IMPLICITWAIT}

    Set Selenium Speed     ${SELENUIMSPEED}
    Enable Logging

Test Isolation Setup
    Go To    ${URL}
    Delete All Cookies
    Reload Page

Close Browser
    Close All Browsers
    Disable Logging

Enable Logging
    Set Log Level    DEBUG

Disable Logging
    Set Log Level    INFO

