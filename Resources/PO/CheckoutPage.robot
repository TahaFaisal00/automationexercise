*** Settings ***
Library     SeleniumLibrary
Library     String


*** Variables ***
${COMMENT_FIELD}                        name=message
${PLACE_ORDER_BUTTON}                   xpath=//a[@href='/payment']

${CHECKOUT_URL}                         https://automationexercise.com/checkout
${ADDRESS_DELIVERY}                     @id='address_delivery'
${ADDRESS_DELIVERY_DETAILS_LOCATOR}     xpath=//ul[${ADDRESS_DELIVERY}]//li[contains(@class,'{}')]

${FULL_NAME_LOCATOR}                    xpath=//ul[${ADDRESS_DELIVERY}]//li[contains(@class,'address_firstname')]
${COUNTRY_LOCATOR_CLASS}                address_country_name
${MOBILE_PHONE_LOCATOR_CLASS}           address_phone

${ADDRESS_AND_COMPANY_LOCATOR}          ${FULL_NAME_LOCATOR}/following-sibling::li[{}]
${COMPANY_LOCATOR_POSITION}             1
${ADDRESS1_LOCATOR_POSITION}            2
${ADDRESS2_LOCATOR_POSITION}            3

${CITY_AND_STATE_AND_ZIPCODE_CLASS}     address_state_name


*** Keywords ***
Verify Checkout Page Loaded
    Wait Until Page Contains    Checkout
    Location Should Be    ${CHECKOUT_URL}

Get Delivery Full Name
    ${full_name}=    Get Text    ${FULL_NAME_LOCATOR}
    RETURN    ${full_name}

Get Delivery City State Zipcode
    ${locator}=    Format String    ${ADDRESS_DELIVERY_DETAILS_LOCATOR}    ${CITY_AND_STATE_AND_ZIPCODE_CLASS}
    ${text}=    Get Text    ${locator}
    RETURN    ${text}

Add Order Comment
    [Arguments]    ${comment}
    Input Text    ${COMMENT_FIELD}    ${comment}

Click Place Order Button
    Click link    ${PLACE_ORDER_BUTTON}
    Wait Until Page Contains    Payment
