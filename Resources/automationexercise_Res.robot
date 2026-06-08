*** Settings ***
Library         SeleniumLibrary
Library         FakerLibrary
Resource        Common.robot
Resource        TestData.robot
Resource        API_RES.robot
Resource        PO/HomePage.robot
Resource        PO/Signup_LoginPage.robot
Resource        PO/ProductsPage.robot
Resource        PO/CartPage.robot
Resource        PO/CheckoutPage.robot
Resource        PO/Payment.robot

*** Keywords ***
Setup Account Test
    [Documentation]     Clean client state, then create a fresh account by API
    Common.Test Isolation Setup
    API_RES.Create Account Via API

Log In And Verify
    [Documentation]     Logs a user in and confirms they're signed in.
    ...                 Use for positive login or as an authenticated-session
    ...                 precondition; for negative cases use Log In With Credentials.
    [Arguments]                               ${email}      ${password}     ${user_name}
    Navigate To Signup And Login Page
    Log In With Credentials                          ${email}       ${password}
    HomePage.Verify Account Signed In           ${user_name}

Navigate To Signup And Login Page
    [Documentation]     Goes from the home page to Signup/Login page and asserting both pages loaded
    HomePage.Verify Home Page Loaded
    HomePage.Click Signup And Login Page Link
    Signup_LoginPage.Verify Signup Login Page Loaded

Log In With Credentials
    [Documentation]     Logs in with the given credentials on the Login page.
    [Arguments]         ${email}        ${password}
    Signup_LoginPage.Enter Email To Login            ${email}
    Signup_LoginPage.Enter Password To Login         ${password}
    Signup_LoginPage.Click Login Button

Log Out And Verify
    [Documentation]     Logs the user out and confirms they're signed out.
    [Arguments]         ${user_name}
    HomePage.Click Logout Link
    HomePage.Verify Account Signed Out      ${user_name}

Generate New Account Data
    [Documentation]     Builds the test account — unique fields from Faker, fixed
    ...                 fields from testdata — and publishes it for the rest of the
    ...                 test (register, verify, delete).
    ${fake_register_user_name}=     FakerLibrary.Name
    ${fake_register_email}=         FakerLibrary.Email
    ${fake_register_password}=      FakerLibrary.Password
    VAR     &{TEST_ACCOUNT}        user_name=${fake_register_user_name}        email=${fake_register_email}        password=${fake_register_password}
    ...     first_name=${SIGNUP_DETAILS.first_name}      second_name=${SIGNUP_DETAILS.second_name}      title=${SIGNUP_DETAILS.title}
    ...     company=${SIGNUP_DETAILS.company}    address1=${SIGNUP_DETAILS.address1}    address2=${SIGNUP_DETAILS.address2}    country=${SIGNUP_DETAILS.country}
    ...     state=${SIGNUP_DETAILS.state}    city=${SIGNUP_DETAILS.city}    zipcode=${SIGNUP_DETAILS.zipcode}    mobile_number=${SIGNUP_DETAILS.mobile_number}      scope=TEST

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

Submit Initial Signup
    [Documentation]     Submits the initial signup (name + email), opening the account details form.
    [Arguments]              ${account}
    Signup_LoginPage.Enter Name To Signup New User         ${account.user_name}
    Signup_LoginPage.Enter Email To Signup New User        ${account.email}
    Signup_LoginPage.Click Signup Button

Enter Date Of Birth
    [Documentation]     Selects the date of birth on the account details form.
    [Arguments]             ${dob}
    Signup_LoginPage.Select Day In Date Of Birth            ${dob.day}
    Signup_LoginPage.Select Month In Date Of Birth          ${dob.month}
    Signup_LoginPage.Select Year In Date Of Birth           ${dob.year}

Enter Account Information
    [Documentation]     Enters the account information fields on the signup form.
    [Arguments]             ${account}
    Signup_LoginPage.Enter Password        ${account.password}
    Signup_LoginPage.Choose Title            ${account.title}

Enter Address Information
    [Documentation]     Enters the address information section of the signup form.
    [Arguments]               ${account}
    Signup_LoginPage.Enter First Name       ${account.first_name}
    Signup_LoginPage.Enter Last Name        ${account.second_name}
    Signup_LoginPage.Enter Company Name      ${account.company}
    Signup_LoginPage.Enter Address 1           ${account.address1}
    Signup_LoginPage.Enter Address 2           ${account.address2}
    Signup_LoginPage.Select Country            ${account.country}
    Signup_LoginPage.Enter State               ${account.state}
    Signup_LoginPage.Enter City                ${account.city}
    Signup_LoginPage.Enter Zipcode             ${account.zipcode}
    Signup_LoginPage.Enter Mobile Number       ${account.mobile_number}

Complete Account Creation
    [Documentation]     Submits the completed signup form and confirms the new
    ...                 account is created and signed in on the home page.
    [Arguments]                   ${account}
    Signup_LoginPage.Click Create Account Button
    Signup_LoginPage.Verify Account Created
    Signup_LoginPage.Click Continue Button After Account Creation
    HomePage.Verify Home Page Loaded
    HomePage.Verify Account Signed In           ${account.user_name}

Delete Account
    [Documentation]     Deletes the logged-in account through the UI and confirms it's gone.
    ...                 For test cleanup use Delete Account Via API instead.
    [Arguments]             ${user_name}
    Go To    ${URL}
    HomePage.Verify Home Page Loaded
    HomePage.Click Delete Account Link
    HomePage.Verify Account Deleted         ${user_name}
    HomePage.Click Continue After Account Deletion






Invalid Credentials
    [Arguments]                                       ${User}
    Go To                                             ${LOGIN URL}
    Signup&LoginPage.Verify Signup and Login Page is Loaded
    Enter Login Credentials                           ${User}
    Signup&LoginPage.Error                            ${User}       ${LOGIN URL}






Navigate to Products Use Search and Assert Results
    [Arguments]                         ${Product}      ${ValidSearchResult}      ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}
    Navigate to Products and verify Products
    Search for a Product                ${Product}
    Search Results                      ${ValidSearchResult}      ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}

Navigate to Products Use Category Filtering and Assert Results
    [Arguments]                         ${CategoryMenu}         ${Category}          ${Product}      ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}
    Navigate to Products and verify Products
    Choose a Category                   ${CategoryMenu}         ${Category}
    Search Results                      ${Product}      ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}

Navigate to Products Use Brands Filtering and Assert Results
    [Arguments]                         ${Brand}            ${Category}             ${Product}      ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}
    Navigate to Products and verify Products
    Choose a Brand                      ${Brand}            ${Category}
    Search Results                      ${Product}      ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}

Navigate to Products Use Search with Invalid Input and Assert Results
    [Arguments]                         ${Product}          ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}
    Navigate to Products and verify Products
    Search for a Product                ${Product}
    Results Should Be Empty                      ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}

Results Should Be Empty
    [Arguments]            ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}
    ProductsPage.Search Result Should not Contain        ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}

Choose a Brand
    [Arguments]     ${Brand}            ${Category}
    ProductsPage.Click on a Brand                ${Brand}
    ProductsPage.Verify Filtering Result         ${Category}

Choose a Category
    [Arguments]                             ${CategoryMenu}         ${Category}
    ProductsPage.Click on Category Menu                  ${CategoryMenu}
    ProductsPage.Click on a Category from a Menu         ${Category}

Navigate to Products and verify Products
    HomePage.Navigate to Products
    ProductsPage.Verify Products Page Loaded
    ProductsPage.All Products       ${MEN TSHIRT}   ${LACE TOP FOR WOMEN}     ${FROZEN TOPS FOR KIDS}       ${BLUE TOP}

Search for a Product
    [Arguments]             ${Product}
    ProductsPage.Write into the Search Bar           ${Product}
    ProductsPage.Click the Search Button

Search Results
    [Arguments]         ${Product}      ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}
    ProductsPage.Search Result Should Contain            ${Product}
    ProductsPage.Search Result Should not Contain        ${Invalid Product1}         ${Invalid Product2}         ${Invalid Product3}








Editing the Quantity of an Item in the Cart
    [Arguments]         ${Product}          ${ExpectedQuantity}        ${EditedQuantity}
    Quantity Should be Editable         ${Product}
    Click on the Quantity of Item       ${Product}          ${ExpectedQuantity}
    Editing the Quantity in Cart          ${Product}          ${ExpectedQuantity}        ${EditedQuantity}

Editing the Quantity of an Item to a minus Number and Navigate to Cart
    [Arguments]                      ${ProductPath}            ${MinusQuantity}
    HomePage.View a Product Details         ${ProductPath}
    ProductsPage.Editing the Quantity              ${MinusQuantity}
    Add a Product to Cart from Product Details
    ProductsPage.Click View Cart Button after Adding an Item
    CartPage.Verify Shopping Cart Page is Loaded

Navigate to a Product Page and Write a Review
    [Arguments]                             ${ProductPath}     ${User}             ${Review}
    HomePage.View a Product Details         ${ProductPath}
    Submit Product Review                   ${User}             ${Review}

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

Adding A product to The Cart and Comment on the Order from the Checkout Page
    [Arguments]         ${ProductPath}          ${Comment}
    Adding a Product to the Cart from Products Page and Enter Cart          ${ProductPath}
    CartPage.Click Proceed to Checkout Button
    CheckoutPage.Verify Checkout Page Loaded
    CheckoutPage.Add a Comment About your Order             ${Comment}

Adding A product to The Cart and Delete it
    [Arguments]             ${ProductPath}
    Adding a Product to the Cart from Products Page and Enter Cart          ${ProductPath}
    Delete an Item from the Shopping Cart               ${ProductPath}


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


Verify The Total Price Valditiy in Cart
    [Arguments]                       ${Productpath}
    CartPage.Total Price Shouldn't be Negative          ${Productpath}


Handle Ad
    [Documentation]     Closes Google Ad iframe that appears mid-test               Frame selection handles iframe context then clicks 'dismiss button'
    Sleep    2s
    Run Keyword And Ignore Error    Select Frame    xpath=//*[@id='ad_iframe']
    Run Keyword And Ignore Error    Click Element    xpath=//*[@id='dismiss-button']
    Run Keyword And Ignore Error    Unselect Frame








