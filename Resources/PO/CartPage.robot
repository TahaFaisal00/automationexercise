*** Settings ***
Library         SeleniumLibrary



*** Keywords ***
Verify Shopping Cart Page is Loaded
    Wait Until Page Contains      Shopping Cart






Verify Product In Cart
    [Arguments]                  ${Product Path}
    Element Should Be Visible    xpath=[${Product Path}]
#xpath=//*[text()='Men Tshirt']

Verify Product Quantity
    [Arguments]                  ${Product Path}        ${Numbers}
    Element Should Be Visible    xpath=[${Product Path} and @class='cart_quantity' and text()='${Numbers}']








Click Delete Item Button
    [Arguments]                  ${Product Path}
    Click Element                xpath=//*[${Product Path} and @class='cart_quantity_delete']
Verify that Items is Deleted
    [Arguments]                  ${Product Path}
    Element Should Not Be Visible    xpath=//*[${Product Path}]





Click Proceed to Checkout Button
    Click Element                xpath=//*[text()='Proceed To Checkout']



















