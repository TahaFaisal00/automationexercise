*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${COMMENT_FIELD}            name=message
${PLACE_ORDER_BUTTON}       xpath=//a[@href='/payment']

${CHECKOUT_URL}         https://automationexercise.com/checkout

*** Keywords ***
# TODO:send it to RES then fix it - ignore for now
Verify Delivery And Billing Address Details
    [Arguments]            ${details}
    Wait Until Page Contains    Address Details
    Wait Until Page Contains    Your delivery address
    Wait Until Page Contains    ${details.first_name}
    Wait Until Page Contains    ${details.Company}
    Wait Until Page Contains    ${details.address1}
    Wait Until Page Contains    ${details.address2}
    Wait Until Page Contains    ${details.state}
    Wait Until Page Contains    ${details.mobile_number}


Verify Checkout Page Loaded
    Wait Until Page Contains    Checkout
    Location Should Be    ${CHECKOUT_URL}

Add Order Comment
    [Arguments]            ${comment}
    Input Text    ${COMMENT_FIELD}    ${comment}

Click Place Order Button
    Click link    ${PLACE_ORDER_BUTTON}
    Wait Until Page Contains    Payment


