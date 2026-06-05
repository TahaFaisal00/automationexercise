*** Settings ***
Library         SeleniumLibrary
Resource        ../automationexerciseRes.robot


*** Keywords ***


Editing Quantity
    [Arguments]                       ${quantity}
    Click Element                     xpath=//*[@id='quantity']
    Press Keys                        xpath=//*[@id='quantity']           CTRL+a+DELETE
    Input Text                        xpath=//*[@id='quantity']           ${quantity}

Write Review
    [Arguments]     ${user}             ${review}
    Input Text    xpath=//*[@id='name']      ${user}
    Input Text    xpath=//*[@id='email']     ${user}
    Input Text    xpath=//*[@id='review']    ${review}
    Click Element    xpath=//*[@type='submit']

Verify Review Submitted
    Wait Until Page Contains    Thank you for your review.

Click Add to cart Button from Product Details Page
    Click Element    xpath=//*[@class='btn btn-default cart']

Click Continue Shopping Button After Adding Item
    Click Element               xpath=//*[contains (normalize-space(),'Continue Shopping')]

Click View Cart Button after Adding Item
    Click Link                   xpath=//*[@id='cartModal']//a[@href='/view_cart']
    Wait Until Page Contains      Shopping Cart

Verify All Products Visible
    [Arguments]              ${product1}            ${product2}     ${product3}         ${product4}
    Element Should Be Visible               xpath=//*[contains(normalize-space() , '${product1}')]
    Element Should Be Visible               xpath=//*[contains(normalize-space() , '${product2}')]
    Element Should Be Visible               xpath=//*[contains(normalize-space() , '${product3}')]
    Element Should Be Visible               xpath=//*[contains(normalize-space() , '${product4}')]

Use Search Bar
    [Arguments]                    ${search}
    Input Text              xpath=//*[@id='search_product']            ${search}
    Click Element           xpath=//*[@id='submit_search']

Choose Category from Category Menu
    [Arguments]                    ${category_menu}      ${category}
    Click Element                 ${category_menu}
    Click Link                   ${category}
    Wait Until Page Contains     ${category}

Click on Brand
    [Arguments]                 ${brand}     ${brand_page}
    Click Link                  ${brand}
    Wait Until Page Contains    ${brand_page}

Search Result Should Contain
    [Arguments]                 ${product}
    Element Should Be Visible    xpath=//*[contains(normalize-space() , '${product}')]

Search Result Should not Contain
    [Arguments]                  ${invalid_product1}         ${invalid_product2}         ${invalid_product3}
    Element Should Not Be Visible      xpath=//*[contains(normalize-space() , '${invalid_product1}')]
    Element Should Not Be Visible      xpath=//*[contains(normalize-space() , '${invalid_product2}')]
    Element Should Not Be Visible      xpath=//*[contains(normalize-space() , '${invalid_product3}')]











