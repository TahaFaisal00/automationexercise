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

${CITY_AND_STATE_AND_ZIPCODE_CLASS}     address_state_name
*** Keywords ***
Verify Checkout Page Loaded
    Wait Until Page Contains    Checkout
    Location Should Be    ${CHECKOUT_URL}

Verify First Name
    [Arguments]     ${expected_first_name}
    ${actual_full_name}=       Get Text    ${FULL_NAME_LOCATOR}
    Run Keyword And Continue On Failure     Should Contain    ${actual_full_name}    ${expected_first_name}

Verify Last Name
    [Arguments]     ${expected_last_name}
    ${actual_last_name}=       Get Text    ${FULL_NAME_LOCATOR}
    Run Keyword And Continue On Failure     Should Contain    ${actual_last_name}    ${expected_last_name}

Verify Company
    [Arguments]     ${expected_company}
    ${company_locator}=     Format String    ${ADDRESS_AND_COMPANY_LOCATOR}        ${COMPANY_LOCATOR_POSITION}
    ${actual_company}=      Get Text     ${company_locator}
    Run Keyword And Continue On Failure     Should Be Equal As Strings    ${actual_company}    ${expected_company}

Verify Address1
    [Arguments]     ${expected_address1}
    ${address1_locator}=     Format String    ${ADDRESS_AND_COMPANY_LOCATOR}        ${ADDRESS1_LOCATOR_POSITION}
    ${actual_address1}=      Get Text     ${address1_locator}
    Run Keyword And Continue On Failure     Should Be Equal As Strings    ${actual_address1}    ${expected_address1}

Verify Address2
    [Arguments]     ${expected_address2}
    ${address2_locator}=     Format String    ${ADDRESS_AND_COMPANY_LOCATOR}        ${ADDRESS2_LOCATOR_POSITION}
    ${actual_address2}=      Get Text     ${address2_locator}
    Run Keyword And Continue On Failure     Should Be Equal As Strings    ${actual_address2}    ${expected_address2}

Verify City
    [Arguments]     ${expected_city}
    ${city_locator}=     Format String    ${ADDRESS_DELIVERY_DETAILS_LOCATOR}        ${CITY_AND_STATE_AND_ZIPCODE_CLASS}
    ${actual_city}=      Get Text     ${city_locator}
    Run Keyword And Continue On Failure     Should Contain    ${actual_city}    ${expected_city}

Verify State
    [Arguments]     ${expected_state}
    ${state_locator}=     Format String    ${ADDRESS_DELIVERY_DETAILS_LOCATOR}        ${CITY_AND_STATE_AND_ZIPCODE_CLASS}
    ${actual_state}=      Get Text     ${state_locator}
    Run Keyword And Continue On Failure     Should Contain    ${actual_state}    ${expected_state}

Verify Zipcode
    [Arguments]     ${expected_zipcode}
    ${zipcode_locator}=     Format String    ${ADDRESS_DELIVERY_DETAILS_LOCATOR}        ${CITY_AND_STATE_AND_ZIPCODE_CLASS}
    ${actual_zipcode}=      Get Text     ${zipcode_locator}
    Run Keyword And Continue On Failure     Should Contain    ${actual_zipcode}    ${expected_zipcode}

Verify Country
    [Arguments]     ${expected_country}
    ${country_locator}=     Format String    ${ADDRESS_DELIVERY_DETAILS_LOCATOR}        ${COUNTRY_LOCATOR_CLASS}
    ${actual_country}=      Get Text    ${country_locator}
    Run Keyword And Continue On Failure     Should Be Equal As Strings    ${actual_country}    ${expected_country}

Verify Mobile Number
    [Arguments]            ${expected_mobile_number}
    ${mobile_phone_locator}=        Format String    ${ADDRESS_DELIVERY_DETAILS_LOCATOR}        ${MOBILE_PHONE_LOCATOR_CLASS}
    ${actual_mobile_number}=        Get Text    ${mobile_phone_locator}
    Run Keyword And Continue On Failure     Should Contain    ${actual_mobile_number}    ${expected_mobile_number}

Add Order Comment
    [Arguments]            ${comment}
    Input Text    ${COMMENT_FIELD}    ${comment}

Click Place Order Button
    Click link    ${PLACE_ORDER_BUTTON}
    Wait Until Page Contains    Payment


