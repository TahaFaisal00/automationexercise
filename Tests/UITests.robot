*** Settings ***
Library                              SeleniumLibrary
Resource                             ../Resources/Common.robot
Resource                             ../Resources/automationexerciseRes.robot
Suite Setup                          Common.Launch Browser
Suite Teardown                       Common.Close Browser

*** Test Cases ***
Login and Logout
    [Tags]
    Login
    Click Element                    xpath=//*[text()='Logout']
    Wait Until Element Is Visible    xpath=//*[@alt='Website for automation practice'

Adding a Product to the Cart from Products Page
    Click Element                xpath=//*[text()='Men Tshirt' and text()='Add to cart']
    Alert Should Be Present      Your product has been added to cart

View a Product Details
    [Tags]
    Login
    Wait Until Element Is Visible    xpath=//*[text()='Men Tshirt']
    Click Link                       xpath=//*[text()='Men Tshirt' and text()='View Product']

Adding a Product to the Cart from Product Details Page
    [Tags]
    Click Element    xpath=//*[text()='Add to cart']
    Alert Should Be Present    Your product has been added to cart
    1Click Element               xpath=//*[text()='Continue Shopping']
    2Click Link                   xpath=//*[text()='View Cart']

Click Continue Shopping Button After Adding an Item
    1Click Element               xpath=//*[text()='Continue Shopping']

Click View Cart Button after Adding an Item
    2Click Link                   xpath=//*[text()='View Cart']
    Wait Until Page Contains      Shopping Cart
    Element Should Be Visible    xpath=//*[text()='Men Tshirt']


Verify that Item Exist in The Cart
    Element Should Be Visible    xpath=//*[text()='Blue Top']
    Element Should Be Visible    xpath=[text()='Men Tshirt' and@class='cart_quantity' and text()='${NUMBERS}]
Delete an Item from the Shopping Cart
    Click Element                xpath=//*[text()='Blue Top' and @class='cart_quantity_delete']

Verify that Items Have been Deleted
    Element Should Not Be Visible    xpath=//*[text()='Blue Top']


Click Proceed to Checkout Button
    Click Element                xpath=//*[text()='Proceed To Checkout']

Verify that Checkout Page is Loaded
    Page Should Contain    Address Details
    Page Should Contain    Your delivery address
    Page Should Contain    ${Main User firstName}
    Page Should Contain    ${Main User secondName}
    Page Should Contain    ${Address1}
    Page Should Contain    ${City}
    Page Should Contain    ${Country}
    Page Should Contain    ${mobileNumber}

    Page Should Contain                    Review Your Order
    Element Should Be Visible              xpath=//*[text()='Blue Top']
    Element Should Be Visible              xpath=[text()='Men Tshirt' and@class='cart_quantity' and text()='${NUMBERS}]

Add a Comment About your Order
    ${Arguments}            ${Comment}
    Input Text    xpath=//*[@class='form-control' and @name='message']    ${Comment}

Click Place Order Button
    Click link    xpath=//*[text()='Place Order']


Navigate to the Shopping Cart
    Click Link                            xpath=//*[text()='Cart']

Verify Shopping Cart Page is Loaded
    Wait Until Page Contains             Shopping Cart

Editing the Quantity
    [Arguments]                       ${NUMBERS}
    Click Element                     xpath=//*[@id='Cart']
    Press Keys                        xpath=//*[@id='Cart']           CTRL+a+DELETE
    Input Text                        xpath=//*[@id='Cart']           ${NUMBERS}


Editing the Quantity of an Item to a minus Number
    [Arguments]                       ${NUMBERS}
    Click Element                     xpath=//*[@id='Cart']
    Press Keys                        xpath=//*[@id='Cart']           CTRL+a+DELETE
    Input Text                        xpath=//*[@id='Cart']           ${NUMBERS}
    Click Element    xpath=//*[text()='Add to cart']
    Alert Should Be Present    Your product has been added to cart
    Click Link                   xpath=//*[text()='View Cart']
    Wait Until Page Contains      Shopping Cart
    Element Should Be Visible    xpath=//*[text()='Men Tshirt']
    Element Should Be Visible    xpath=[text()='Men Tshirt' and@class='cart_quantity' and text()='${NUMBERS}]



Verify that Payment page is Loaded
    Wait Until Page Contains    Payment


Enter Name on Card
    [Arguments]                       ${NAME}
    Input Text            xpath=//*[@data-qa='name-on-card']    ${NAME}
Enter Card Number
    [Arguments]                       ${NUMBER}
    Input Text            xpath=//*[@data-qa='card-number']    ${NUMBER}
Enter CVC
    [Arguments]                       ${CVC}
    Input Text            xpath=//*[@data-qa='cvc']           ${CVC}
Enter Expiration Month
    [Arguments]                       ${MONTH}
    Input Text            xpath=//*[@data-qa='expiry-month']    ${MONTH}
Enter Expiration Year
    [Arguments]                       ${YEAR}
    Input Text            xpath=//*[@data-qa='expiry-year']    ${YEAR}



Entering Credit Card Details
    [Arguments]                          ${CARD}
    Enter Name on Card                   ${CARD.Name}
    Enter Card Number                    ${CARD.Card Number}
    Enter CVC                            ${CARD.CVC}
    Enter Expiration Month               ${CARD.Expiration Date month}
    Enter Expiration Year                ${CARD.Expiration Date Year}




Click Pay and Confirm Order Button
    Click Element    xpath=//*[text()='Pay and Confirm Order']

Verify that Order was Submitted
    Wait Until Page Contains    Your order has been placed successfully!





Writing a Review for the an Item
    [Arguments]                 ${NAME}         ${EMAIL}        ${REVIEW}
    Input Text    xpath=//*[@id='name']      ${NAME}
    Input Text    xpath=//*[@id='email']     ${EMAIL}
    Input Text    xpath=//*[@id='review']    ${REVIEW}

    Wait Until Page Contains    Thank you for your review.
    Click Element    xpath=[text()='Submit']

Handle Ad
    Run Keyword And Ignore Error     Click Element    xpath=//


























