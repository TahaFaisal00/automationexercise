*** Settings ***
Library         SeleniumLibrary

*** Keywords ***
Verify Product In Cart
    [Arguments]                  ${product}
    Element Should Be Visible    xpath=//*[contains(normalize-space() , '${product}')]

Verify Product Quantity
    [Arguments]                  ${product}     ${expected_quantity}
    Element Should Be Visible    xpath=//*[contains(normalize-space() , '${product}')]/ancestor::tr//td[@class='cart_quantity']//button[contains(normalize-space() , '${expected_quantity}')]

Verify Quantity in Cart Editable
    [Arguments]         ${product}
    ${button}=      Get Element Attribute    xpath=//*[contains(normalize-space() , '${product}')]/ancestor::tr//button        class
    Should Not Contain    ${button}    disabled

Click on Quantity of Item
    [Arguments]         ${product}          ${expected_quantity}
    Click Element    xpath=//*[contains(normalize-space() , '${product}')]/ancestor::tr//*[contains(normalize-space() , '${expected_quantity}')]

Verify Total Price in Cart not Negative
    [Arguments]                       ${product}
    ${total}=       Get Text    xpath=//*[contains(normalize-space() , '${product}')]/ancestor::tr//td[@class='cart_total']//p[@class='cart_total_price']
    Should Not Contain    ${total}    -

Click Delete Item Button
    [Arguments]                  ${product}
    Click Element                xpath=//*[contains(normalize-space() , '${product}')]/ancestor::tr//td[@class='cart_delete']//a[@class='cart_quantity_delete']

Verify Item Deleted
    [Arguments]                  ${product}
    Element Should Not Be Visible    xpath=//*[contains(normalize-space() , '${product}')]

Click Proceed to Checkout Button
    Click Element                xpath=//*[contains(normalize-space() , 'Proceed To Checkout')]
    Wait Until Page Contains                    Checkout


















