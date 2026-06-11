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

${REGISTER_LOGIN}                   xpath=//div[@class='modal-content']//a[@href='/login']
*** Keywords ***
Verify Cart Page Loaded
    Wait Until Page Contains    Shopping Cart
    Location Should Be          ${CART_URL}

Click On Quantity Of Item
    [Arguments]         ${product}
    ${product_quantity_location}=        Format String    ${PRODUCT_QUANTITY}        ${product}
    Click Element    ${product_quantity_location}

Click Delete Item Button
    [Arguments]                  ${product}
    ${product_delete_button_location}=      Format String    ${PRODUCT_DELETE_BUTTON}       ${product}
    Click Element                ${product_delete_button_location}

Click Proceed To Checkout Button
    Click Element                ${PROCEED_TO_CHECKOUT_BUTTON}
    Wait Until Page Contains                    Checkout

Click Register Or Login On Checkout Block
    Wait Until Element Is Visible    ${REGISTER_LOGIN}
    Click Element                    ${REGISTER_LOGIN}
















