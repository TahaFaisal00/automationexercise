*** Settings ***
Library         SeleniumLibrary
Library         String
*** Variables ***
# ${PRODUCT_BASE} Won't work alone. add [class='...'] to it
${PRODUCT_BASE}                     xpath=//a[normalize-space()='{}']/ancestor::tr//td
${PRODUCT_QUANTITY}                 ${PRODUCT_BASE}[@class='cart_quantity']//button
${PRODUCT_TOTAL_PRICE}              ${PRODUCT_BASE}[@class='cart_total']//p[@class='cart_total_price']
${PRODUCT_DELETE_BUTTON}            ${PRODUCT_BASE}[@class='cart_delete']//a[@class='cart_quantity_delete']

${CART_PRODUCT_LOCATOR}                          xpath=//a[normalize-space()='{}']
${PROCEED_TO_CHECKOUT_BUTTON}       xpath=//a[normalize-space()='Proceed To Checkout']

${CART_URL}                         https://automationexercise.com/view_cart
*** Keywords ***
Verify Cart Page Loaded
    Wait Until Page Contains    Shopping Cart
    Location Should Be          ${CART_URL}


Verify Quantity Not Editable In Cart
    [Documentation]     BUG:cart quantity should be editable but the button have the class 'disabled'. asserts the field is editable expected to fail until the defect is fixed
    [Arguments]         ${product}
    ${product_quantity_location}=        Format String    ${PRODUCT_QUANTITY}        ${product}
    ${button}=      Get Element Attribute    ${product_quantity_location}        class
    Should Not Contain    ${button}    disabled

Click On Quantity Of Item
    [Arguments]         ${product}
    ${product_quantity_location}=        Format String    ${PRODUCT_QUANTITY}        ${product}
    Click Element    ${product_quantity_location}

Verify Product Total Price In Cart Is Negative
    [Documentation]         Verifies the product's total line price in the cart is negative — documents the negative-quantity bug.
    [Arguments]                       ${product}
    ${product_total_price_location}=      Format String    ${PRODUCT_TOTAL_PRICE}       ${product}
    ${product_total_price}=       Get Text    ${product_total_price_location}
    ${product_clean_price}=     Replace String    ${product_total_price}    Rs.    ${EMPTY}
    ${number}=      Convert To Number    ${product_clean_price}
    Should Be True    ${number} < 0


Click Delete Item Button
    [Arguments]                  ${product}
    ${product_delete_button_location}=      Format String    ${PRODUCT_DELETE_BUTTON}       ${product}
    Click Element                ${product_delete_button_location}

Verify Item Deleted
    [Arguments]                  ${product}
    ${product_location}=     Format String    ${PRODUCT}     ${product}
    Wait Until Element Is Not Visible    ${product_location}

Click Proceed To Checkout Button
    Click Element                ${PROCEED_TO_CHECKOUT_BUTTON}
    Wait Until Page Contains                    Checkout


















