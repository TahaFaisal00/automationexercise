*** Settings ***
Library         SeleniumLibrary



*** Keywords ***
Verify Shopping Cart Page is Loaded
    Wait Until Page Contains      Shopping Cart

Verify Product In Cart
    [Arguments]                  ${Product}
    Element Should Be Visible    xpath=//*[${Product}]

Verify Product Quantity
    [Arguments]                  ${Product}     ${ExpectedQuantity}
    Element Should Be Visible    xpath=//*[${Product}]/ancestor::tr//td[@class='cart_quantity']//button[text()='${ExpectedQuantity}']




Quantity Should be Editable
    [Arguments]         ${Product}
    ${button}=      Get Element Attribute    xpath=//*[${Product}]/ancestor::tr//button        class
    Should Not Contain    ${button}    disabled


Click on the Quantity of Item
    [Arguments]         ${Product}          ${ExpectedQuantity}
    Click Element    xpath=//*[${Product}]/ancestor::tr//*[text()='${ExpectedQuantity}']

Editing the Quantity in Cart
    [Arguments]                       ${Product}       ${ExpectedQuantity}          ${Quantity}
    Press Keys                        xpath=//*[${Product}]/ancestor::tr//*[text()='${ExpectedQuantity}']           CTRL+a+DELETE
    Input Text                        xpath=//*[${Product}]/ancestor::tr//*[text()='${ExpectedQuantity}']           ${Quantity}




Click Delete Item Button
    [Arguments]                  ${Product}
    Click Element                xpath=//*[${Product.Product Path and @class='cart_quantity_delete']
Verify that Items is Deleted
    [Arguments]                  ${Product}
    Element Should Not Be Visible    xpath=//*[${Product}]

Click Proceed to Checkout Button
    Click Element                xpath=//*[text()='Proceed To Checkout']



















