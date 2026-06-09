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
    [Documentation]     Goes to Signup/Login page and assert page loaded
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
    ...     state=${SIGNUP_DETAILS.state}    city=${SIGNUP_DETAILS.city}    zipcode=${SIGNUP_DETAILS.zipcode}    mobile_number=${SIGNUP_DETAILS.mobile_number}
    ...     day=${DATE_OF_BIRTH.day}        month=${DATE_OF_BIRTH.month}         year=${DATE_OF_BIRTH.year}             scope=TEST

Register New Account
    [Documentation]         Registers a new account end to end — from the signup page
    ...                     through to a signed-in home page. The reusable full flow.
    [Arguments]                                     ${account}
    Navigate To Signup And Login Page
    Submit Initial Signup                           ${account}
    Signup_LoginPage.Verify Signup Page Loaded     ${account.user_name}        ${account.email}
    Enter Account Information                       ${account}
    Enter Date Of Birth                             ${account}
    Signup_LoginPage.Select Newsletter Checkbox
    Signup_LoginPage.Select Partners Offers Checkbox
    Enter Address Information                       ${account}
    Complete Account Creation                       ${account}

Submit Initial Signup
    [Documentation]     Submits the initial signup (name + email), opening the account details form.
    [Arguments]              ${account}
    Signup_LoginPage.Enter Name To Signup New User         ${account.user_name}
    Signup_LoginPage.Enter Email To Signup New User        ${account.email}
    Signup_LoginPage.Click Signup Button

Enter Date Of Birth
    [Documentation]     Selects the date of birth on the account details form.
    [Arguments]             ${account}
    Signup_LoginPage.Select Day In Date Of Birth            ${account.day}
    Signup_LoginPage.Select Month In Date Of Birth          ${account.month}
    Signup_LoginPage.Select Year In Date Of Birth           ${account.year}

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

Verify Login Fails
    [Documentation]     Attempts login with the given credentials and confirms
    ...                 they're rejected.
    [Arguments]                                       ${account}
    Navigate To Signup And Login Page
    Log In With Credentials                           ${account.email}      ${account.password}
    Verify Login Error              ${account.email}      ${account.password}

Verify Login Error
    [Documentation]         erifies the expected login validation (required fields or
    ...                invalid-credentials error) and that the user stays on the login page.
    [Arguments]                                   ${$email}      ${$password}
    IF    $email == ""
         Signup_LoginPage.Verify Email Field Is Required
    ELSE IF    $password == ""
         Signup_LoginPage.Verify Password Field Is Required
    ELSE
         Signup_LoginPage.Verify Invalid Credentials Error
    END
    Signup_LoginPage.Verify Signup Login Page Loaded

Search Products And Verify Results
    [Documentation]     Searches the products page and verifies the expected
    ...                 products appear while the others don't.
    [Arguments]       ${all_products}      ${expected_product}     @{unexpected_products}
    Enter Products Page And Checks Products         @{all_products}
    ProductsPage.Use Search Bar     @{expected_product}
    Verify Search Results           ${expected_product}         @{unexpected_products}

Choose Category And Verify Results
    [Documentation]     Filters the products page with category and verifies the expected products appear while the others don't.
    [Arguments]             ${all_products}     ${menu}    ${category}        ${expected_product}         @{unexpected_products}
    Enter Products Page And Checks Products         @{all_products}
    ProductsPage.Choose Category From Category Menu     ${menu}    ${category}
    Verify Search Results                   ${expected_product}         @{unexpected_products}

Choose Brand Filter And Verify Results
    [Documentation]     Filters the products page with a brand and verifies the expected products appear while the others don't.
    [Arguments]     ${all_products}     ${brand}        ${brand_page}       ${expected_product}         @{unexpected_products}
    Enter Products Page And Checks Products         @{all_products}
    Click On Brand          ${brand}        ${brand_page}
    Verify Search Results   ${expected_product}         @{unexpected_products}

Enter Products Page And Checks Products
    [Documentation]     Goes to products page and check if all the products are loaded
    [Arguments]     ${all_products}
    Navigate To Products Page
    Verify All Products Visible           @{all_products}

Navigate To Products Page
    [Documentation]     Goes to Products page and assert it loaded
    HomePage.Click Products Page Link
    ProductsPage.Verify Products Page Loaded

Verify Search Results
    [Documentation]     Verifies the expected product appears in the results and the others don't.
    [Arguments]     ${expected_product}      @{unexpected_products}
    ProductsPage.Search Result Should Contain       ${expected_product}
    ProductsPage.Search Result Should Not Contain       @{unexpected_products}


Add Product To Cart And Open Cart
    [Documentation]     Adds a specific product to shopping cart and navigate to it
    [Arguments]          ${products}       ${product}
    HomePage.Verify Home Page Loaded
    ProductsPage.Verify All Products Visible            @{products}
    HomePage.Add Item To Cart From Products Page         ${product}
    HomePage.Verify Product Added To Cart
    HomePage.Click Shopping Cart Page Link
    CartPage.Verify Cart Page Loaded

Add Product To Cart And Continue Shopping
    [Documentation]     Adds a specific product to shopping cart
    [Arguments]          ${products}       ${product}
    HomePage.Verify Home Page Loaded
    ProductsPage.Verify All Products Visible            @{products}
    HomePage.Add Item To Cart From Products Page         ${product}
    HomePage.Verify Product Added To Cart

Verify Products In Cart
    [Documentation]     Check if the given products exist in cart after adding them
    [Arguments]                    @{products}
    FOR    ${product}    IN    @{products}
        ${product_location}=     Format String    ${CART_PRODUCT_LOCATOR}     ${product}
        Run Keyword And Continue On Failure     Wait Until Element Is Visible    ${product_location}
    END

Normalize To List
    [Arguments]    ${value}
    ${is_list}=    Evaluate    isinstance($value, list)
    IF    not ${is_list}
        ${value}=    Create List    ${value}
    END
    RETURN    ${value}

Verify Product Quantities In Cart
    [Documentation]      Verifies each product's displayed quantity in the cart matches the expected value.
    ...                  Accepts a single product + single quantity, or parallel lists of products and quantities.
    ...                  Lists must be equal length and in matching order.
    [Arguments]                  ${products}     ${expected_quantities}
    ${products}=                     Normalize To List    ${products}
    ${expected_quantities}=          Normalize To List    ${expected_quantities}
    FOR    ${product}    ${expected_quantity}    IN ZIP    ${products}    ${expected_quantities}
        ${product_quantity_location}=        Format String    ${PRODUCT_QUANTITY}        ${product}
        ${actual_quantity}=     Get Text    ${product_quantity_location}
        Run Keyword And Continue On Failure        Should Be Equal As Strings    ${actual_quantity}    ${expected_quantity}
    END

Editing Quantity Of Product In Cart
    [Documentation]      Check if the quantity of product in cart is editable then proceed to click it
    [Arguments]                             ${product}
    CartPage.Verify Quantity Not Editable In Cart        ${product}

Delete Product From Shopping Cart
    [Documentation]     Deletes the product from the cart and verifies its removal.
    [Arguments]                                  ${product}
    CartPage.Click Delete Item Button            ${product}
    CartPage.Verify Item Deleted                 ${product}



Navigate to a Product Page and Write a Review
    [Arguments]                             ${ProductPath}     ${User}             ${Review}
    HomePage.View a Product Details         ${ProductPath}
    Submit Product Review                   ${User}             ${Review}

Submit Product Review
    [Arguments]             ${User}             ${Review}
    ProductsPage.Enter Name for Review           ${User}
    ProductsPage.Enter Email for Review          ${User}
    ProductsPage.Write a Review                  ${Review}
    ProductsPage.Click Submit Review
    ProductsPage.Verify Review Submitted




Add a Product to Cart from Product Details
    ProductsPage.Click Add to cart Button from Product Details Page
    HomePage.Verify Product Added to Cart


Editing the Quantity of an Item to a minus Number and Navigate to Cart
    [Arguments]                      ${ProductPath}            ${MinusQuantity}
    HomePage.View a Product Details         ${ProductPath}
    ProductsPage.Editing the Quantity              ${MinusQuantity}
    Add a Product to Cart from Product Details
    ProductsPage.Click View Cart Button after Adding an Item
    CartPage.Verify Shopping Cart Page is Loaded


Adding A product to The Cart and Comment on the Order from the Checkout Page
    [Arguments]         ${ProductPath}          ${Comment}
    Adding a Product to the Cart from Products Page and Enter Cart          ${ProductPath}
    CartPage.Click Proceed to Checkout Button
    CheckoutPage.Verify Checkout Page Loaded
    CheckoutPage.Add a Comment About your Order             ${Comment}




Adding a Product to the Cart from Products Page and Continue Shopping
    [Arguments]         ${ProductPath}
    HomePage.Hover And Click Add to Cart Button         ${ProductPath}
    HomePage.Verify Product Added to Cart

Verify Cart Item And Quantity
    [Arguments]                  ${ProductPath}        ${ExpectedQuantity}
    CartPage.Verify Product In Cart      ${ProductPath}
    CartPage.Verify Product Quantity        ${ProductPath}            ${ExpectedQuantity}



Verify The Total Price Valditiy in Cart
    [Arguments]                       ${Productpath}
    CartPage.Total Price Shouldn't be Negative          ${Productpath}

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

Handle Ad
    [Documentation]     Closes Google Ad iframe that appears mid-test               Frame selection handles iframe context then clicks 'dismiss button'
    Sleep    2s
    Run Keyword And Ignore Error    Select Frame    xpath=//*[@id='ad_iframe']
    Run Keyword And Ignore Error    Click Element    xpath=//*[@id='dismiss-button']
    Run Keyword And Ignore Error    Unselect Frame








