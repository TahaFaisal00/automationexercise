*** Settings ***
Library         SeleniumLibrary



*** Keywords ***
Verify Shopping Cart Page is Loaded
    Wait Until Page Contains      Shopping Cart

Verify Product In Cart
    [Arguments]                  ${Product}
    Element Should Be Visible    xpath=[${Product.Product Path}]

Verify Product Quantity
    [Arguments]                  ${Product}     ${Quantity}
    Element Should Be Visible    xpath=[${Product.Product Path} and @class='cart_quantity' and text()='${Quantity}']

Click Delete Item Button
    [Arguments]                  ${Product}
    Click Element                xpath=//*[${Product.Product Path and @class='cart_quantity_delete']
Verify that Items is Deleted
    [Arguments]                  ${Product}
    Element Should Not Be Visible    xpath=//*[${Product.Product Path}]

Click Proceed to Checkout Button
    Click Element                xpath=//*[text()='Proceed To Checkout']



















