*** Settings ***
Library                 SeleniumLibrary

*** Variables ***
${BROWSER}               chrome
${URL}                   https://automationexercise.com/
${WINDOWS_WIDTH}         1280
${WINDOWS_HEIGHT}        1024
${IMPLICIT_WAIT}         10s
${SELENIUM_SPEED}        0
${HEADLESS}              ${FALSE}

${AD_BLOCK_RULES}    --host-resolver-rules=MAP *.doubleclick.net 127.0.0.1,MAP *.googlesyndication.com 127.0.0.1,MAP *.googleadservices.com 127.0.0.1
*** Keywords ***
Launch Browser
    [Documentation]    Opens Chrome with configured options.
    ...                Headed by default for local debugging.
    ...                Override in CI with: --variable HEADLESS:True.
    ${options}=    Evaluate    selenium.webdriver.ChromeOptions()    modules=selenium.webdriver
    IF    ${HEADLESS}
        Call Method    ${options}    add_argument    --headless=new
    END
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    ${AD_BLOCK_RULES}
    Open Browser    ${URL}    ${BROWSER}    options=${options}

    Set Window Size       ${WINDOWS_WIDTH}    ${WINDOWS_HEIGHT}
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}
    Set Selenium Speed     ${SELENIUM_SPEED}
Test Isolation Setup
    [Documentation]     Resets client state before each test so tests are independent of execusion order.
    Delete All Cookies
    Execute Javascript          window.localStorage.clear()
    Execute Javascript          window.sessionStorage.clear()
    Go To                       ${URL}

Shutdown Browser
    [Documentation]     Closes all browser sessions. Use as Suite Teardown
    Close All Browsers



