*** Settings ***
Library         SeleniumLibrary
Resource        Common.robot
Resource        PO/HomePage.robot
Resource        PO/Signup&LoginPage.robot
Resource        PO/ProductsPage.robot
Resource        PO/CartPage.robot
Resource        PO/CheckoutPage.robot
Resource        PO/Payment.robot

*** Variables ***
${LOGIN URL}                 https://automationexercise.com/login
&{MAIN USER}                 Username=Taha           Email=taha111@gmail.com      Password=taha2021       firstName=Taha      secondName=Moe
&{DELETED USER}              Username=Delete           Email=Delete111@gmail.com      Password=Delete2021       firstName=Delete      secondName=Me
&{DATE OF BIRTH}             Day=20            Month=August          Year=2000
&{SIGNUP DETAILS}            Title=Mr    Company=Robo    Address1=1    Address2=2    Country=United States    State=NY    City=NY    Zipcode=10001    MobileNumber=71264241

&{CREDIT CARD}               Name=TAHA MOE EOM       CardNumber=8709 9213 1245 2810            CVC=720        ExpirationDatemonth=3     ExpirationDateYear=2029

&{PRODUCT}                 ProductPath=text()='Men Tshirt'       BaseQuantity=1             EditedQuantity=2       MinusQuantity=-5    EditedExpectedQuantity=2            MinusExpectedQuantity=1

&{USER EMPTY EMAIL}                  Email=${EMPTY}              Password=mmmm21
&{USER EMPTY PASSWORD}               Email=mmmm@gmail.com        Password=${EMPTY}




*** Keywords ***

Invalid Credentials
    [Arguments]                                       ${User}
    Go To                                        ${URL}
    Navigate to Signup and Login Page
    Enter Login Credentials                           ${User}
    Signup&LoginPage.Error                            ${User}       ${LOGIN URL}












Register a New Account
    [Arguments]                                     ${User}          ${Date}        ${Details}
    Navigate to Signup and Login Page
    Enter Name and Email to Signup a New User       ${User}
    Signup&LoginPage.Click Signup Button to Continue The Signing Up
    Signup&LoginPage.Verify Signup Page is Loaded
    Enter firstName, secondName and Password        ${User}
    Enter the Date of Birth                         ${Date}
    Signup&LoginPage.Click Sign up for our newsletter! Checkbox
    Signup&LoginPage.Click Receive special offers from our partners! Checkbox
    Entering the Other Details                      ${Details}
    Complete Account Creation                       ${User}

Enter Name and Email to Signup a New User
    [Arguments]              ${User}
    Signup&LoginPage.Enter Name to Signup a New User         ${User.Username}
    Signup&LoginPage.Enter Email to Signup a New User        ${User.Email}

Enter the Date of Birth
    [Arguments]             ${Date}
    Signup&LoginPage.Enter a Day in the Date of Birth            ${Date.Day}
    Signup&LoginPage.Enter a Month in the Date of Birth          ${Date.Month}
    Signup&LoginPage.Enter a Year in the Date of Birth           ${Date.Year}

Enter firstName, secondName and Password
    [Arguments]             ${User}
    Signup&LoginPage.Enter a Password        ${User.Password}
    Signup&LoginPage.Enter a firstName       ${User.firstName}
    Signup&LoginPage.Enter a lastName        ${User.secondName}

Entering the Other Details
    [Arguments]               ${Details}
    Signup&LoginPage.Choose a Title            ${Details.Title}
    Signup&LoginPage.Enter a Company Name      ${Details.Company}
    Signup&LoginPage.Enter Address 1           ${Details.Address1}
    Signup&LoginPage.Enter Address 2           ${Details.Address2}
    Signup&LoginPage.Enter a Country           ${Details.Country}
    Signup&LoginPage.Enter a State             ${Details.State}
    Signup&LoginPage.Enter a City              ${Details.City}
    Signup&LoginPage.Enter a Zipcode           ${Details.Zipcode}
    Signup&LoginPage.Enter Mobile Number       ${Details.MobileNumber}

Navigate to Signup and Login Page
    HomePage.Verify Home Page is Loaded
    HomePage.Click on Signup and Login
    Signup&LoginPage.Verify Signup and Login Page is Loaded

Complete Account Creation
    [Arguments]                   ${User}
    Signup&LoginPage.Click Create Account Button
    Signup&LoginPage.Verify Account is Created
    Signup&LoginPage.Click Continue Button
    HomePage.Verify Home Page is Loaded
    HomePage.Verify Account Signed in Successfully           ${User.Username}



Login
    [Arguments]                                   ${user}
    Navigate to Signup and Login Page
    Enter Login Credentials                           ${user}
    HomePage.Verify Account Signed in Successfully           ${user.Username}
    Handle Ad




Enter Login Credentials
    [Arguments]         ${Credentials}
    Signup&LoginPage.Enter Email to Login            ${Credentials.Email}
    Signup&LoginPage.Enter Password to Login         ${Credentials.Password}
    Signup&LoginPage.Click on Login Button



Logout
    [Arguments]         ${User}
    HomePage.Click on Logout
    HomePage.Verify Account Signed Out Successfully      ${User}


Delete Account
    [Arguments]             ${user}
    Click Delete Account
    Verify Account Deleted
    Signup&LoginPage.Click Continue Button
    HomePage.Verify Home Page is Loaded
    HomePage.Verify Account Signed Out Successfully      ${User}



Editing the Quantity of an Item in the Cart
    [Arguments]         ${Product}          ${ExpectedQuantity}        ${EditedQuantity}
    Quantity Should be Editable         ${Product}
    Click on the Quantity of Item       ${Product}          ${ExpectedQuantity}
    Editing the Quantity in Cart          ${Product}          ${ExpectedQuantity}        ${EditedQuantity}
    Verify Cart Item And Quantity       ${Product}      ${EditedQuantity}



Editing the Quantity of an Item to a minus Number and Check it in Cart
    [Arguments]                      ${ProductPath}            ${MinusQuantity}          ${EditedQuantity}
    HomePage.View a Product Details         ${ProductPath}
    ProductsPage.Editing the Quantity              ${MinusQuantity}
    Add a Product to Cart from Product Details
    ProductsPage.Click View Cart Button after Adding an Item
    CartPage.Verify Shopping Cart Page is Loaded
    Verify Cart Item And Quantity        ${ProductPath}        ${EditedQuantity}


Add a Product to Cart from Product Details
    ProductsPage.Click Add to cart Button from Product Details Page
    HomePage.Verify Product Added to Cart


Submit Product Review
    [Arguments]             ${User}             ${Review}
    ProductsPage.Enter Name for Review           ${User}
    ProductsPage.Enter Email for Review          ${User}
    ProductsPage.Write a Review                  ${Review}
    ProductsPage.Click Submit Review
    ProductsPage.Verify Review Submitted

Adding a Product to the Cart from Products Page and Enter Cart
    [Arguments]         ${ProductPath}
    HomePage.Hover And Click Add to Cart Button         ${ProductPath}
    HomePage.Verify Product Added to Cart
    HomePage.Navigate to the Shopping Cart

Adding a Product to the Cart from Products Page and Continue Shopping
    [Arguments]         ${ProductPath}
    HomePage.Hover And Click Add to Cart Button         ${ProductPath}
    HomePage.Verify Product Added to Cart


Verify Cart Item And Quantity
    [Arguments]                  ${ProductPath}        ${ExpectedQuantity}
    CartPage.Verify Product In Cart      ${ProductPath}
    CartPage.Verify Product Quantity        ${ProductPath}            ${ExpectedQuantity}

Delete an Item from the Shopping Cart
    [Arguments]                         ${ProductPath}
    CartPage.Click Delete Item Button            ${ProductPath}
    CartPage.Verify that Items is Deleted        ${ProductPath}



Complete Placing Order
    [Arguments]            ${User}       ${ProductPath}        ${Numbers}
    CheckoutPage.Verify Checkout Page Loaded
    CheckoutPage.Verify Delivery and Billing Address Details         ${User}
    Verify Cart Item And Quantity           ${ProductPath}        ${Numbers}
    CheckoutPage.Click Place Order Button

Complete payment and Confirm Order
    [Arguments]                             ${CARD}
    Entering Credit Card Details            ${CARD}
    Payment.Click Pay and Confirm Order Button
    Payment.Verify that Order was Submitted

Entering Credit Card Details
    [Arguments]                          ${CARD}
    Payment.Enter Name on Card                   ${CARD.Name}
    Payment.Enter Card Number                    ${CARD.CardNumber}
    Payment.Enter CVC                            ${CARD.CVC}
    Payment.Enter Expiration Month               ${CARD.ExpirationDatemonth}
    Payment.Enter Expiration Year                ${CARD.ExpirationDateYear}







#Handle Ad
#    Sleep    2s
#    Run Keyword And Ignore Error    Click Element    xpath=//*[@id='dismiss-button']








