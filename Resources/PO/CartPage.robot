*** Settings ***
Library         SeleniumLibrary



*** Keywords ***
Verify Shopping Cart Page is Loaded
    Wait Until Page Contains      Shopping Cart

Verify Product In Cart
    [Arguments]                  ${Productpath}
    Element Should Be Visible    xpath=//*[text()='${Productpath}']

Verify Product Quantity
    [Arguments]                  ${Productpath}     ${ExpectedQuantity}
    Element Should Be Visible    xpath=//*[text()='${Productpath}']/ancestor::tr//td[@class='cart_quantity']//button[text()='${ExpectedQuantity}']




Quantity Should be Editable
    [Arguments]         ${Productpath}
    ${button}=      Get Element Attribute    xpath=//*[text()='${Productpath}']/ancestor::tr//button        class
    Should Not Contain    ${button}    disabled


Click on the Quantity of Item
    [Arguments]         ${Productpath}          ${ExpectedQuantity}
    Click Element    xpath=//*[text()='${Productpath}']/ancestor::tr//*[text()='${ExpectedQuantity}']

Editing the Quantity in Cart
    [Arguments]                       ${Productpath}       ${ExpectedQuantity}          ${Quantity}
    Press Keys                        xpath=//*[text()='${Productpath}']/ancestor::tr//*[text()='${ExpectedQuantity}']           CTRL+a+DELETE
    Input Text                        xpath=//*[text()='${Productpath}']/ancestor::tr//*[text()='${ExpectedQuantity}']           ${Quantity}



Total Price Shouldn't be Negative
    [Arguments]                       ${Productpath}
    ${Total}=       Get Text    xpath=//*[text()='${Productpath}']/ancestor::tr//td[@class='cart_total']//p[@class='cart_total_price']
    Should Not Contain    ${Total}    -






Click Delete Item Button
    [Arguments]                  ${Productpath}
    Click Element                xpath=//*[text()='${Productpath}']/ancestor::tr//td[@class='cart_delete']//a[@class='cart_quantity_delete']
Verify that Items is Deleted
    [Arguments]                  ${Productpath}
    Element Should Not Be Visible    xpath=//*[text()='${Productpath}']

Click Proceed to Checkout Button
    Click Element                xpath=//*[text()='Proceed To Checkout']



















