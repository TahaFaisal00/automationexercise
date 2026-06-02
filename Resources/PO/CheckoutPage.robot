*** Settings ***
Library         SeleniumLibrary



*** Keywords ***

Verify Checkout Page Loaded
    Page Should Contain                    Checkout
    Page Should Contain                    Review Your Order

Verify Delivery and Billing Address Details
    [Arguments]            ${Details}
    Page Should Contain    Address Details
    Page Should Contain    Your delivery address
    Page Should Contain    ${Details.firstName}
    Page Should Contain    ${Details.Company}
    Page Should Contain    ${Details.Address1}
    Page Should Contain    ${Details.Address2}
    Page Should Contain    ${Details.NY}
    Page Should Contain    ${Details.71264241}

Add a Comment About your Order
    ${Arguments}            ${Comment}
    Input Text    xpath=//*[@class='form-control' and @name='message']    ${Comment}

Click Place Order Button
    Click link    xpath=//*[text()='Place Order']



