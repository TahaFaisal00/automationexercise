*** Settings ***
Library         SeleniumLibrary
Library         String
*** Variables ***
${COMMENT_FIELD}            name=message
${PLACE_ORDER_BUTTON}       xpath=//a[@href='/payment']

${CHECKOUT_URL}         https://automationexercise.com/checkout
${ADDRESS_DELIVERY}     @id='address_delivery'
${ADDRESS_DELIVERY_DETAILS_LOCATOR}     xpath=//ul[${ADDRESS_DELIVERY}]//li[contains(@class,'{}')]

${FULL_NAME_LOCATOR}               xpath=//ul[${ADDRESS_DELIVERY}]//li[contains(@class,'address_firstname')]
${COUNTRY_LOCATOR_CLASS}                 address_country_name
${MOBILE_PHONE_LOCATOR_CLASS}            address_phone

${ADDRESS_AND_COMPANY_LOCATOR}      ${FULL_NAME_LOCATOR}/following-sibling::li[{}]
${COMPANY_LOCATOR_POSITION}         1
${ADDRESS1_LOCATOR_POSITION}        2
${ADDRESS2_LOCATOR_POSITION}        3

*** Keywords ***
Verify Checkout Page Loaded
    Wait Until Page Contains    Checkout
    Location Should Be    ${CHECKOUT_URL}

#for referencing only - Delete after completing the keywords
Verify Delivery And Billing Address Details
    [Documentation]         Checks all the address details of the user in checkout page
    [Arguments]                 ${details}
    Wait Until Page Contains    ${details.first_name}
    Wait Until Page Contains    ${details.company}
    Wait Until Page Contains    ${details.address1}
    Wait Until Page Contains    ${details.address2}
    Wait Until Page Contains    ${details.state}
    Wait Until Page Contains    ${details.mobile_number}

Verify Full Name
    [Arguments]     ${account}
    ${full_name}=       Get Text    ${FULL_NAME_LOCATOR}
    Should Contain    ${full_name}    ${account}


























Add Order Comment
    [Arguments]            ${comment}
    Input Text    ${COMMENT_FIELD}    ${comment}

Click Place Order Button
    Click link    ${PLACE_ORDER_BUTTON}
    Wait Until Page Contains    Payment


