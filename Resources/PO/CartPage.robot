*** Settings ***
Library         SeleniumLibrary
Library         String
*** Variables ***
# ${PRODUCT_BASE} Won't work alone. add [class='...'] to it
${PRODUCT_BASE}                     xpath=//a[normalize-space()='{}']/ancestor::tr//td
${PRODUCT_QUANTITY}                 ${PRODUCT_BASE}[@class='cart_quantity']//button
${PRODUCT_TOTAL_PRICE}              ${PRODUCT_BASE}[@class='cart_total']//p[@class='cart_total_price']
${PRODUCT_DELETE_BUTTON}            ${PRODUCT_BASE}[@class='cart_delete']//a[@class='cart_quantity_delete']

${PRODUCT}                          xpath=//a[normalize-space()='{}']
${PROCEED_TO_CHECKOUT_BUTTON}       xpath=//a[normalize-space()='Proceed To Checkout']

${CART_URL}                         https://automationexercise.com/view_cart
*** Keywords ***
Verify Cart Page Loaded
    Wait Until Page Contains    Shopping Cart
    Location Should Be          ${CART_URL}

Verify Product In Cart
    [Arguments]                  @{products}
    FOR    ${product}    IN    @{products}
        ${product_location}=     Format String    ${PRODUCT}     ${product}
        Run Keyword And Continue On Failure     Wait Until Element Is Visible    ${product_location}
    END

# TODO:send it to RES then fix it - ignore for now:
Verify Product Quantities
    [Arguments]                  ${products}     ${expected_quantities}
    FOR    ${product}    ${expected_quantity}    IN ZIP    ${products}    ${expected_quantities}
        ${product_quantity_location}=        Format String    ${PRODUCT_QUANTITY}        ${product}
        ${actual_quantity}=     Get Text    ${product_quantity_location}
        Run Keyword And Continue On Failure        Should Be Equal As Strings    ${actual_quantity}    ${expected_quantity}
    END


    ${product_quantity_location}=        Format String    ${PRODUCT_QUANTITY}        ${product}
    ${actual_quantity}=     Get Text    ${product_quantity_location}
    Should Be Equal As Strings    ${actual_quantity}    ${expected_quantity}

Verify Quantity In Cart Editable
    [Documentation]     BUG:cart quantity should be editable but the button have the class 'disabled'. asserts the field is editable expected to fail until the defect is fixed
    [Arguments]         ${product}
    ${product_quantity_location}=        Format String    ${PRODUCT_QUANTITY}        ${product}
    ${button}=      Get Element Attribute    ${product_quantity_location}        class
    Should Not Contain    ${button}    disabled

Click On Quantity Of Item
    [Arguments]         ${product}
    ${product_quantity_location}=        Format String    ${PRODUCT_QUANTITY}        ${product}
    Click Element    ${product_quantity_location}

Verify Total Price In Cart Not Negative
    [Documentation]         After Adding a Negative Amount from the 'Product Page'
    [Arguments]                       ${product}
    ${product_total_price_location}=      Format String    ${PRODUCT_TOTAL_PRICE}       ${product}
    ${total}=       Get Text    ${product_total_price_location}
    Should Not Contain    ${total}    -

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


















