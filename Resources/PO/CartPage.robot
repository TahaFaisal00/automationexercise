*** Settings ***
Library         SeleniumLibrary
Library         String
*** Variables ***
# ${PRODUCT_BASE} Won't work alone. add [class='...'] to it
${PRODUCT_BASE_IN_CART}                     xpath=//a[normalize-space()='{}']/ancestor::tr//td
${PRODUCT_QUANTITY}                 ${PRODUCT_BASE_IN_CART}\[@class='cart_quantity']//button
${PRODUCT_TOTAL_PRICE}              ${PRODUCT_BASE_IN_CART}\[@class='cart_total']//p[@class='cart_total_price']
${PRODUCT_DELETE_BUTTON}            ${PRODUCT_BASE_IN_CART}\[@class='cart_delete']//a[@class='cart_quantity_delete']

${CART_PRODUCT_LOCATOR}                          xpath=//a[normalize-space()='{}']
${PROCEED_TO_CHECKOUT_BUTTON}       xpath=//a[normalize-space()='Proceed To Checkout']

${CART_URL}                         https://automationexercise.com/view_cart

${REGISTER_LOGIN}                   xpath=//div[@class='modal-content']//a[@href='/login']

${CHECKOUT_BLOCK_CENTER}            xpath=//div[@class='modal-content']//p[@class='text-center' and not(a)]
*** Keywords ***
Verify Cart Page Loaded
    Wait Until Page Contains    Shopping Cart
    Location Should Be          ${CART_URL}

Click On Quantity Of Item
    [Arguments]         ${product}
    ${product_quantity_location}=        Format String    ${PRODUCT_QUANTITY}        ${product}
    Click Element    ${product_quantity_location}

Get Checkout Block Message
    Wait Until Element Is Visible    ${CHECKOUT_BLOCK_CENTER}
    ${block_text}=       Get Text    ${CHECKOUT_BLOCK_CENTER}
    RETURN      ${block_text}




Click Delete Item Button
    [Arguments]                  ${product}
    ${product_delete_button_location}=      Format String    ${PRODUCT_DELETE_BUTTON}       ${product}
    Click Element                ${product_delete_button_location}

Click Proceed To Checkout Button
    Wait Until Page Contains Element    ${PROCEED_TO_CHECKOUT_BUTTON}
    Click Element                ${PROCEED_TO_CHECKOUT_BUTTON}

Click Register Or Login On Checkout Block
    Wait Until Element Is Visible    ${REGISTER_LOGIN}
    Click Element                    ${REGISTER_LOGIN}
















