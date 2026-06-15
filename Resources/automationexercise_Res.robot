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
Resource        PO/PaymentPage.robot

*** Keywords ***
Setup Account Test
    [Documentation]     Clean client state, then create a fresh account by API
    Common.Test Isolation Setup
    API_RES.Create Account With Retry

Log In And Verify
    [Documentation]     Logs a user in and confirms they're signed in.
    ...                 Use for positive login or as an authenticated-session
    ...                 precondition; for negative cases use Log In With Credentials.
    [Arguments]                               ${email}      ${password}     ${user_name}
    Navigate To Signup And Login Page
    Log In With Credentials                          ${email}       ${password}
    Verify Account Signed In           ${user_name}

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
    Verify Account Signed Out      ${user_name}

Generate New Account Data
    [Documentation]     Builds the test account — unique fields from Faker, fixed
    ...                 fields from testdata — and publishes it for the rest of the
    ...                 test (register, verify, delete).
    ${fake_register_user_name}=     FakerLibrary.Name
    ${fake_register_email}=         FakerLibrary.Email
    ${fake_register_password}=      FakerLibrary.Password
    VAR     &{TEST_ACCOUNT}        user_name=${fake_register_user_name}        email=${fake_register_email}        password=${fake_register_password}
    ...     first_name=${SIGNUP_DETAILS.first_name}      last_name=${SIGNUP_DETAILS.last_name}      title=${SIGNUP_DETAILS.title}
    ...     company=${SIGNUP_DETAILS.company}    address1=${SIGNUP_DETAILS.address1}    address2=${SIGNUP_DETAILS.address2}    country=${SIGNUP_DETAILS.country}
    ...     state=${SIGNUP_DETAILS.state}    city=${SIGNUP_DETAILS.city}    zipcode=${SIGNUP_DETAILS.zipcode}    mobile_number=${SIGNUP_DETAILS.mobile_number}
    ...     day=${DATE_OF_BIRTH.day}        month=${DATE_OF_BIRTH.month}         year=${DATE_OF_BIRTH.year}             scope=TEST

Register New Account
    [Documentation]         Registers a new account end to end — from the signup page
    ...                     through to a signed-in home page. The reusable full flow.
    [Arguments]                                     ${account}
    Navigate To Signup And Login Page
    Submit Initial Signup                           ${account}
    Signup_LoginPage.Verify Signup Page Loaded
    Verify Signup Name And Email            ${account.user_name}      ${account.email}
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
    Signup_LoginPage.Enter Last Name        ${account.last_name}
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
    Verify Account Created
    Signup_LoginPage.Click Continue Button After Account Creation
    HomePage.Verify Home Page Loaded
    Verify Account Signed In           ${account.user_name}

Delete Account
    [Documentation]     Deletes the logged-in account through the UI and confirms it's gone.
    ...                 For test cleanup use Delete Account Via API instead.
    [Arguments]             ${user_name}
    Go To    ${URL}
    HomePage.Verify Home Page Loaded
    HomePage.Click Delete Account Link
    Verify Account Deleted         ${user_name}
    HomePage.Click Continue After Account Deletion

Verify Login Fails
    [Documentation]     Attempts login with the given credentials and confirms
    ...                 they're rejected.
    [Arguments]                                       ${account}
    Navigate To Signup And Login Page
    Log In With Credentials                           ${account.email}      ${account.password}
    Verify Login Error              ${account.email}      ${account.password}

Verify Login Error
    [Documentation]         Verifies the expected login validation (required fields or
    ...                invalid-credentials error) and that the user stays on the login page.
    [Arguments]                                   ${email}      ${password}
    IF    $email == ""
         Verify Email Field Is Required
    ELSE IF    $password == ""
         Verify Password Field Is Required
    ELSE
         Verify Invalid Credentials Error
    END
    Signup_LoginPage.Verify Signup Login Page Loaded

Search Products And Verify Results
    [Documentation]     Searches the products page and verifies the expected
    ...                 products appear while the others don't.
    [Arguments]       ${all_products}    ${searched_product}         ${expected_product}     @{unexpected_products}
    Enter Products Page And Checks Products         ${all_products}
    ProductsPage.Use Search Bar     ${searched_product}
    Verify Search Results           ${expected_product}         @{unexpected_products}

Choose Category And Verify Results
    [Documentation]     Filters the products page with category and verifies the expected products appear while the others don't.
    [Arguments]             ${all_products}     ${menu}    ${category}    ${category_page}    ${expected_product}         @{unexpected_products}
    Enter Products Page And Checks Products         ${all_products}
    ProductsPage.Choose Category From Category Menu     ${menu}    ${category}      ${category_page}
    Verify Search Results                   ${expected_product}         @{unexpected_products}

Choose Brand Filter And Verify Results
    [Documentation]     Filters the products page with a brand and verifies the expected products appear while the others don't.
    [Arguments]     ${all_products}     ${brand}        ${brand_page}       ${expected_product}         @{unexpected_products}
    Enter Products Page And Checks Products         ${all_products}
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


Add Product To Cart And Open Cart
    [Documentation]     Adds a specific product to shopping cart and navigate to it
    [Arguments]          ${products}       ${product}
    HomePage.Verify Home Page Loaded
    ProductsPage.Verify All Products Visible            @{products}
    HomePage.Add Item To Cart From Products Page         ${product}
    HomePage.Verify Product Added To Cart
    Navigate To Cart After Adding Product to Cart

Add Product To Cart And Continue Shopping
    [Documentation]     Adds a specific product to shopping cart
    [Arguments]          ${products}       ${product}
    HomePage.Verify Home Page Loaded
    ProductsPage.Verify All Products Visible            @{products}
    HomePage.Add Item To Cart From Products Page         ${product}
    HomePage.Verify Product Added To Cart
    HomePage.Click Continue Shopping Button

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

Delete Product From Shopping Cart
    [Documentation]     Deletes the product from the cart and verifies its removal.
    [Arguments]                                  ${product}
    CartPage.Click Delete Item Button            ${product}
    Verify Item Deleted                 ${product}

Navigate To Product Details Page
    [Documentation]         Waits until products are loaded then enters the details page of the required product and and verifies it loading.
    [Arguments]           ${products}       ${product}
    HomePage.Verify Home Page Loaded
    ProductsPage.Verify All Products Visible            @{products}
    HomePage.View Product Details               ${product}
    ProductsPage.Verify Product Details Page Loaded         ${product}

Submit Product Review
    [Documentation]     Enters the name, email, and review, submits it, and verifies the submission.
    [Arguments]       ${account}        ${product}
    ProductsPage.Write Review       ${account.user_name}      ${account.email}      ${product.review}
    ProductsPage.Click Submit Review
    Verify Review Submitted

Navigate To Checkout Page From Cart
    [Documentation]     Proceeds from the cart to the checkout page and verifies it loaded.
    ...                 Assumes the cart holds at least one product.
    CartPage.Click Proceed To Checkout Button
    CheckoutPage.Verify Checkout Page Loaded

Verify Delivery Address Details
    [Documentation]         Verifies every delivery-address field on the checkout page
    ...                against the account data. Soft-asserts (continue on failure) so
    ...                one wrong field doesn't mask the others. Page quirks: first and
    ...                last name are read from one combined name element, and
    ...                city/state/zipcode share a single element — those use partial
    ...                matches, not equality. Assumes the checkout page is loaded with
    ...                a saved address.
    [Arguments]                 ${account}
    Verify First Name           ${account.first_name}
    Verify Last Name            ${account.last_name}
    Verify Company              ${account.company}
    Verify Address1             ${account.address1}
    Verify Address2             ${account.address2}
    Verify City                 ${account.city}
    Verify State                ${account.state}
    Verify Zipcode              ${account.zipcode}
    Verify Country              ${account.country}
    Verify Mobile Number        ${account.mobile_number}

Set And Verify Quantity To Negative Number
    [Documentation]     Edits the quantity of product on the product details page to a negative quantity and verifies it.
    [Arguments]         ${quantity}     ${expected_quantity}
    ProductsPage.Set Quantity              ${quantity}
    Verify Quantity Value      ${expected_quantity}

Add Product To Cart From Product Details
    [Documentation]     Adds the product on the product details page to the cart and verifies it was added.
    ProductsPage.Click Add To Cart Button From Product Details Page
    HomePage.Verify Product Added To Cart

Set Quantity And Add To Cart
    [Documentation]     Sets the quantity on the product details page, then adds the product to the cart and verifies it was added.
    [Arguments]     ${quantity}
    ProductsPage.Set Quantity              ${quantity}
    Add Product To Cart From Product Details

Navigate To Cart After Adding Product to Cart
    [Documentation]       Navigates to the shopping cart after adding a product from
    ...    homepage or product details and verifies the cart page loaded.
    HomePage.Click View Cart Link
    CartPage.Verify Cart Page Loaded

Navigate To Cart From Navbar
    [Documentation]     Navigates to the shopping cart via the navbar cart link and
    ...                verifies the cart page loaded.
    HomePage.Click Shopping Cart Link
    CartPage.Verify Cart Page Loaded

Verify Product Total Price In Cart Is Negative
    [Documentation]         Verifies the product's total line price in the cart is negative — documents the negative-quantity bug.
    [Arguments]                       ${product}
    ${product_total_price_location}=      Format String    ${PRODUCT_TOTAL_PRICE}       ${product}
    ${product_total_price}=       Get Text    ${product_total_price_location}
    ${product_clean_price}=     Replace String    ${product_total_price}    Rs.    ${EMPTY}
    ${number}=      Convert To Number    ${product_clean_price}
    Should Be True    ${number} < 0

Comment On Order In Checkout Page And Navigate To Payment
    [Documentation]     Writes a comment on the order on the checkout page, proceeds to payment, and verifies the payment page loaded.
    [Arguments]         ${comment}
    CheckoutPage.Add Order Comment               ${comment}
    CheckoutPage.Click Place Order Button
    PaymentPage.Verify Payment Page Loaded

Navigate From Checkout Page To Payment
    [Documentation]     proceeds to payment, and verifies the payment page loaded.
    CheckoutPage.Click Place Order Button
    PaymentPage.Verify Payment Page Loaded

Enter Credit Card Details
    [Documentation]     Generates throwaway credit card details and enters them on the payment page.
    ${name_on_card}=        FakerLibrary.Name Male
    ${card_number}=         FakerLibrary.Credit Card Number
    ${cvc}=                 FakerLibrary.Credit Card Security Code
    ${expiry_month}=        FakerLibrary.Month
    ${expiry_year}=         FakerLibrary.Year
    VAR     &{TEST_CARD}        name_on_card=${name_on_card}       card_number=${card_number}
    ...              cvc=${cvc}        expiry_month=${expiry_month}       expiry_year=${expiry_year}

    PaymentPage.Enter Name On Card              ${TEST_CARD.name_on_card}
    PaymentPage.Enter Card Number               ${TEST_CARD.card_number}
    PaymentPage.Enter CVC                       ${TEST_CARD.cvc}
    PaymentPage.Enter Expiry Month              ${TEST_CARD.expiry_month}
    PaymentPage.Enter Expiry Year               ${TEST_CARD.expiry_year}

Complete Payment And Confirm Order
    [Documentation]     Pays and confirms the order, verifies it was placed.
    PaymentPage.Click Pay And Confirm Order Button
    Verify Order Submitted

Create Account And Log In
    [Documentation]     Setup fixture. Creates an account via API, then logs in with the generated credentials.
    API_RES.Create Account With Retry
    Log In And Verify    ${TEST_ACCOUNT.email}    ${TEST_ACCOUNT.password}    ${TEST_ACCOUNT.user_name}

Verify Guest Cannot Checkout
    [Documentation]     Asserts a guest is blocked at checkout — the register/login
    ...                modal appears instead of the checkout page.
    ...                Precondition: items in cart and Proceed To Checkout
    ${block_message}=           CartPage.Get Checkout Block Message
    Should Contain    ${block_message}    Login account to proceed on checkout

Attempt Checkout As Guest
    [Documentation]     Guest clicks Proceed To Checkout and is stopped by the
    ...                register/login modal instead of reaching the checkout page.
    Click Proceed To Checkout Button
    Verify Guest Cannot Checkout

Navigate From Cart To Signup After Block
    [Documentation]     Clicks the Register/Login link in the checkout block modal and
    ...                confirms the signup/login page loads.
    ...                Precondition: the guest checkout block modal is open
    ...                (i.e. Attempt Checkout As Guest ran first).
    Click Register Or Login On Checkout Block
    Verify Signup Login Page Loaded


Verify Account Signed In
    [Arguments]             ${user}
    Wait Until Page Contains         Logged in as ${user}

Verify Account Signed Out
    [Arguments]             ${user}
    Wait Until Page Does Not Contain         Logged in as ${user}

Verify Account Deleted
    [Documentation]     Confirms deletion: the 'Account Deleted!' confirmation shows,
    ...                then re-verifies the user is signed out. Asserts more than the
    ...                name implies.
    [Arguments]             ${user}
    Wait Until Page Contains         Account Deleted!
    Wait Until Page Contains         Your account has been permanently
    Verify Account Signed out        ${user}



Verify Signup Name And Email
    [Documentation]     Asserts the name and email echoed back on the signup form match
    ...                what was submitted. Assumes the initial signup step is done.
    [Arguments]                 ${user_name}            ${email}
    ${actual_signup_name}=      Get Value    ${SIGNUP_NAME_SIGNUP_PAGE}
    Should Be Equal As Strings    ${actual_signup_name}    ${user_name}
    ${actual_signup_email}=      Get Value    ${SIGNUP_EMAIL_SIGNUP_PAGE}
    Should Be Equal As Strings     ${actual_signup_email}    ${email}

Verify Account Created
    [Documentation]     Success = the 'Account Created!' confirmation is shown AND the
    ...                location is the account_created page. Both must hold.
    Wait Until Page Contains         Account Created!
    Location Should Be               ${ACCOUNT_CREATED_URL}

Verify Email Field Is Required
    [Documentation]     Proves the email field is mandatory by asserting its HTML
    ...                'required' attribute is set — not by checking for a visible
    ...                error message.
    ${required}=     Get Element Attribute    ${EMAIL_LOGIN_FIELD}       required
    Should Be Equal As Strings                      ${required}          true

Verify Password Field Is Required
    [Documentation]     Proves the password field is mandatory by asserting its HTML
    ...                'required' attribute is set — not by checking for a visible
    ...                error message.
    ${required}=     Get Element Attribute    ${PASSWORD_LOGIN_FIELD}    required
    Should Be Equal As Strings                      ${required}          true

Verify Invalid Credentials Error
    Wait Until Page Contains                            Your email or password is incorrect!


Verify Quantity Value
    [Documentation]      Asserts the product-details quantity input holds the expected
    ...                value.
    [Arguments]                       ${expected_quantity}
    ${actual_quantity}=            Get Value                 ${QUANTITY_FIELD}
    Should Be Equal As Strings    ${actual_quantity}    ${expected_quantity}

Verify Review Submitted
    Wait Until Page Contains    Thank you for your review.

Verify Search Results
    [Documentation]     Asserts the expected product appears when one is expected,
    ...                and that the unexpected products do not appear.
    [Arguments]         ${expected_product}      @{unexpected_products}
    IF    $expected_product != ""
         ProductsPage.Search Result Should Contain      ${expected_product}
    END
    FOR    ${unexpected_product}    IN    @{unexpected_products}
         ProductsPage.Search Result Should Not Contain      ${unexpected_product}
    END


Verify Quantity Not Editable In Cart
    [Documentation]     BUG: cart quantity should be editable but the field carries the 'disabled' class.
    ...                 Asserts the actual (buggy) state so the test stays green and documents the defect;
    ...                flips red if the field is ever made editable.
    [Arguments]         ${product}
    ${product_quantity_location}=        Format String    ${PRODUCT_QUANTITY}        ${product}
    ${class}=      Get Element Attribute    ${product_quantity_location}        class
    Should Contain    ${class}    disabled

Verify Item Deleted
    [Arguments]                  ${product}
    ${product_location}=     Format String   ${CART_PRODUCT_LOCATOR}      ${product}
    Wait Until Element Is Not Visible    ${product_location}



Verify First Name
    [Arguments]     ${expected_first_name}
    ${actual_full_name}=       CheckoutPage.Get Delivery Full Name
    Run Keyword And Continue On Failure     Should Contain    ${actual_full_name}    ${expected_first_name}

Verify Last Name
    [Arguments]     ${expected_last_name}
    ${actual_last_name}=       CheckoutPage.Get Delivery Full Name
    Run Keyword And Continue On Failure     Should Contain    ${actual_last_name}    ${expected_last_name}

Verify Company
    [Arguments]     ${expected_company}
    ${company_locator}=     Format String    ${ADDRESS_AND_COMPANY_LOCATOR}        ${COMPANY_LOCATOR_POSITION}
    ${actual_company}=      Get Text     ${company_locator}
    Run Keyword And Continue On Failure     Should Be Equal As Strings    ${actual_company}    ${expected_company}

Verify Address1
    [Arguments]     ${expected_address1}
    ${address1_locator}=     Format String    ${ADDRESS_AND_COMPANY_LOCATOR}        ${ADDRESS1_LOCATOR_POSITION}
    ${actual_address1}=      Get Text     ${address1_locator}
    Run Keyword And Continue On Failure     Should Be Equal As Strings    ${actual_address1}    ${expected_address1}

Verify Address2
    [Arguments]     ${expected_address2}
    ${address2_locator}=     Format String    ${ADDRESS_AND_COMPANY_LOCATOR}        ${ADDRESS2_LOCATOR_POSITION}
    ${actual_address2}=      Get Text     ${address2_locator}
    Run Keyword And Continue On Failure     Should Be Equal As Strings    ${actual_address2}    ${expected_address2}

Verify City
    [Arguments]     ${expected_city}
    ${expected_city_state_zipcode}=         Get Delivery City State Zipcode
    Run Keyword And Continue On Failure     Should Contain    ${expected_city_state_zipcode}    ${expected_city}

Verify State
    [Arguments]     ${expected_state}
    ${expected_city_state_zipcode}=        Get Delivery City State Zipcode
    Run Keyword And Continue On Failure     Should Contain    ${expected_city_state_zipcode}}    ${expected_state}

Verify Zipcode
    [Arguments]     ${expected_zipcode}
    ${expected_city_state_zipcode}=     Get Delivery City State Zipcode
    Run Keyword And Continue On Failure     Should Contain    ${expected_city_state_zipcode}    ${expected_zipcode}

Verify Country
    [Arguments]     ${expected_country}
    ${country_locator}=     Format String    ${ADDRESS_DELIVERY_DETAILS_LOCATOR}        ${COUNTRY_LOCATOR_CLASS}
    ${actual_country}=      Get Text    ${country_locator}
    Run Keyword And Continue On Failure     Should Be Equal As Strings    ${actual_country}    ${expected_country}

Verify Mobile Number
    [Arguments]            ${expected_mobile_number}
    ${mobile_phone_locator}=        Format String    ${ADDRESS_DELIVERY_DETAILS_LOCATOR}        ${MOBILE_PHONE_LOCATOR_CLASS}
    ${actual_mobile_number}=        Get Text    ${mobile_phone_locator}
    Run Keyword And Continue On Failure     Should Contain    ${actual_mobile_number}    ${expected_mobile_number}


Verify Order Submitted
    Wait Until Element Is Visible    ${ORDER_PLACED_HEADER}
    ${actual_header}=        Get Text    ${ORDER_PLACED_HEADER}
    Should Be Equal As Strings    ${actual_header}    ORDER PLACED!





