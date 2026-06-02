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

&{PRODUCT}                 ProductPath=text()='Men Tshirt'        Quantity=2       MinusQuantity=-5

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








Editing the Quantity of an Item to a minus Number
    [Arguments]                       ${Numbers}             ${Product Path}
    ProductsPage.Editing the Quantity              ${Numbers}
    ProductsPage.Click Add to cart Button from Product Details Page
    HomePage.Verify Product Added to Cart
    ProductsPage.Click View Cart Button after Adding an Item
    CartPage.Verify Shopping Cart Page is Loaded
    Verify Cart Item And Quantity        ${Product Path}        ${Numbers}

Submit Product Review
    [Arguments]             ${User}             ${Review}
    ProductsPage.Enter Name for Review           ${User}
    ProductsPage.Enter Email for Review          ${User}
    ProductsPage.Write a Review                  ${Review}
    ProductsPage.Click Submit Review
    ProductsPage.Verify Review Submitted

Adding a Product to the Cart from Products Page
    HomePage.Click Add to Cart Button
    HomePage.Verify Product Added to Cart



Verify Cart Item And Quantity
    [Arguments]                  ${Product Path}        ${Numbers}
    CartPage.Verify Product In Cart      ${Product Path}
    CartPage.Verify Product Quantity        ${Product Path}     ${Numbers}

Delete an Item from the Shopping Cart
    [Arguments]                         ${Product Path}
    CartPage.Click Delete Item Button            ${Product Path}
    CartPage.Verify that Items is Deleted        ${Product Path}



Complete Placing Order
    [Arguments]            ${User}       ${Product Path}        ${Numbers}
    CheckoutPage.Verify Checkout Page Loaded
    CheckoutPage.Verify Delivery and Billing Address Details         ${User}
    Verify Cart Item And Quantity           ${Product Path}        ${Numbers}
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


















