*** Settings ***
Library                                     RequestsLibrary
Resource                                    ../../Resources/API_RES.robot
Resource                                    ../../Resources/API_TestData.robot
Suite Setup                                 Open Session

*** Test Cases ***
Full Account Lifecycle - Create Login Delete Then Login Fails
    [Documentation]     Verifies the full account lifecycle via API: an account
    ...                created via API can login, and after deletion can
    ...                no longer login (404).
    [Tags]      e2e        api
    [Teardown]      Run Keyword And Ignore Error    Delete Account Via API
    Create Account With Retry
    ${response}=        Login Via API
    Verify Login Succeeds       ${response}
    ${response}=        Delete Account Via API
    Verify Delete Account Succeeds      ${response}
    ${response}=        Login Via API
    Verify Login Fails      ${response}

