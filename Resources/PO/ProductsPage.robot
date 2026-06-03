*** Settings ***
Library         SeleniumLibrary



*** Keywords ***


Editing the Quantity
    [Arguments]                       ${Quantity}
    Click Element                     xpath=//*[@id='quantity']
    Press Keys                        xpath=//*[@id='quantity']           CTRL+a+DELETE
    Input Text                        xpath=//*[@id='quantity']           ${Quantity}

Enter Name for Review
    [Arguments]                 ${User}
    Input Text    xpath=//*[@id='name']      ${User.firstName} ${User.secondName}

Enter Email for Review
    [Arguments]               ${User}
    Input Text    xpath=//*[@id='email']     ${User.Email}

Write a Review
    [Arguments]                 ${Review}
    Input Text    xpath=//*[@id='review']    ${Review}

Click Submit Review
    Click Element    xpath=//*[text()='Submit']

Verify Review Submitted
    Wait Until Page Contains    Thank you for your review.

Click Add to cart Button from Product Details Page
    Click Element    xpath=//*[@class='btn btn-default cart']

Click Continue Shopping Button After Adding an Item
    Click Element               xpath=//*[text()='Continue Shopping']

Click View Cart Button after Adding an Item
    Click Link                   xpath=//*[@id='cartModal']//a[@href='/view_cart']












