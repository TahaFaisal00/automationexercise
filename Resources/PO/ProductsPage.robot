*** Settings ***
Library         SeleniumLibrary
Resource        ../automationexerciseRes.robot


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
    Click Element    xpath=//*[@type='submit']

Verify Review Submitted
    Wait Until Page Contains    Thank you for your review.

Click Add to cart Button from Product Details Page
    Click Element    xpath=//*[@class='btn btn-default cart']

Click Continue Shopping Button After Adding an Item
    Click Element               xpath=//*[text()='Continue Shopping']

Click View Cart Button after Adding an Item
    Click Link                   xpath=//*[@id='cartModal']//a[@href='/view_cart']

Verify Products Page Loaded
    Wait Until Page Contains             All Products

All Products
    [Arguments]              ${Product1}            ${Product2}     ${Product3}         ${Product4}
    Element Should Be Visible               xpath=//*[text()='${Product1}']
    Element Should Be Visible               xpath=//*[text()='${Product2}']
    Element Should Be Visible               xpath=//*[text()='${Product3}']
    Element Should Be Visible               xpath=//*[text()='${Product4}']

Write into the Search Bar
    [Arguments]                    ${Search}
    Input Text              xpath=//*[@id='search_product']            ${Search}

Click the Search Button
    Click Element    xpath=//*[@id='submit_search']


Click on Category Menu
    [Arguments]                    ${CategoryMenu}
    Click Element                 ${CategoryMenu}

Click on a Category from a Menu
    [Arguments]                    ${Category}
    Click Link                   ${Category}

Click on a Brand
    [Arguments]                ${Brand}
    Click Link                 ${Brand}

Verify Filtering Result
    [Arguments]                  ${Category}
    Wait Until Page Contains     ${Category}



Search Result Should Contain
    [Arguments]                 ${Product}
    Element Should Be Visible    xpath=//*[text()='${Product}']

Search Result Should not Contain
    [Arguments]                  ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}
    Element Should Not Be Visible      xpath=//*[text()='${Invalid Product1}']
    Element Should Not Be Visible      xpath=//*[text()='${Invalid Product2}']
    Element Should Not Be Visible      xpath=//*[text()='${Invalid Product3}']











