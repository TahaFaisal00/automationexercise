*** Settings ***
Library         SeleniumLibrary

*** Keywords ***
# TODO:send it to RES
Verify Delivery and Billing Address Details
    [Arguments]            ${details}
    Page Should Contain    Address Details
    Page Should Contain    Your delivery address
    Page Should Contain    ${details.first_name}
    Page Should Contain    ${details.Company}
    Page Should Contain    ${details.address1}
    Page Should Contain    ${details.address2}
    Page Should Contain    ${details.state}
    Page Should Contain    ${details.mobile_number}

Add Order Comment
    [Arguments]            ${comment}
    Input Text    xpath=//*[@class='form-control' and @name='message']    ${comment}

Click Place Order Button
    Click link    xpath=//*[contains(normalize-space() , 'Place Order')]
    Wait Until Page Contains    Payment


