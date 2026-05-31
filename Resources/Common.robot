*** Settings ***
Library         SeleniumLibrary




*** Variables ***
${BROWSER}          chrome
${URL}              https://automationexercise.com/


*** Keywords ***
Launch Browser
    Open Browser           ${URL}      ${BROWSER}
    Set Selenium Speed     1s

Close Browser
    Close All Browsers
