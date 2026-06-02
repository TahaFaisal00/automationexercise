*** Settings ***
Library         SeleniumLibrary



*** Keywords ***


Editing the Quantity
    [Arguments]                       ${Quantity}
    Click Element                     xpath=//*[@id='Cart']
    Press Keys                        xpath=//*[@id='Cart']           CTRL+a+DELETE
    Input Text                        xpath=//*[@id='Cart']           ${Quantity}

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
    Click Element    xpath=//*[text()='Add to cart']

Click Continue Shopping Button After Adding an Item
    Click Element               xpath=//*[text()='Continue Shopping']

Click View Cart Button after Adding an Item
    Click Link                   xpath=//*[text()='View Cart']












