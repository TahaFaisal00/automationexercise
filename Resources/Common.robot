*** Settings ***
Library         SeleniumLibrary




*** Variables ***
${BROWSER}          chrome
${URL}              https://automationexercise.com/


*** Keywords ***
Launch Browser
    Open Browser           ${URL}      ${BROWSER}
    Set Selenium Speed     0.5s

Close Browser
    Close All Browsers
