*** Settings ***
Documentation       UI-driven end-to-end purchase journeys (registered + guest-to-registered).
Library             SeleniumLibrary
Resource            ../../Resources/Common.robot
Resource            ../../Resources/TestData.robot
Resource            ../../Resources/automationexercise_Res.robot
Resource            ../../Resources/API_RES.robot

Suite Setup         Common.Launch Browser
Suite Teardown      Common.Shutdown Browser

*** Test Cases ***
Registered User Completes Purchase
    [Documentation]     Registered user buys two products end-to-end.
    ...                Verifies cart quantities, checkout address matches the
    ...                API-created account, and order confirmation.
    ...                Account created/deleted via API (setup/teardown).
    [Tags]          e2e     ui        positive
    [Setup]         automationexercise_Res.Setup Account Test
    Log In And Verify    ${TEST_ACCOUNT.email}    ${TEST_ACCOUNT.password}    ${TEST_ACCOUNT.user_name}
    automationexercise_Res.Add Product To Cart And Continue Shopping       ${ALL_PRODUCTS}     ${MEN_TSHIRT}
    automationexercise_Res.Navigate To Product Details Page            ${ALL_PRODUCTS}     ${BLUE_TOP}
    automationexercise_Res.Set Quantity And Add To Cart            ${PRODUCT.edited_quantity}
    automationexercise_Res.Navigate To Cart
    automationexercise_Res.Verify Products In Cart         ${MEN_TSHIRT}           ${BLUE_TOP}
    automationexercise_Res.Verify Product Quantities In Cart       ${E2E_CART_PRODUCTS}            ${E2E_CART_QUANTITIES}
    automationexercise_Res.Navigate To Checkout Page From Cart
    automationexercise_Res.Verify Delivery Address Details          ${TEST_ACCOUNT}
    automationexercise_Res.Navigate From Checkout Page To Payment
    automationexercise_Res.Enter Credit Card Details
    automationexercise_Res.Complete Payment And Confirm Order
    automationexercise_Res.Verify Order Submitted
    [Teardown]      API_RES.Delete Account Via API


Guest Converts To Registered And Purchases
    [Documentation]    Guest fills cart, is blocked at checkout, registers via UI,
    ...                then completes purchase. Verifies the unauthenticated
    ...                checkout guard and cart persistence across registration.
    ...                Account deleted via API (teardown).
    [Tags]      e2e     ui      positive
    automationexercise_Res.Add Product To Cart And Continue Shopping       ${ALL_PRODUCTS}     ${MEN_TSHIRT}
    automationexercise_Res.Navigate To Product Details Page            ${ALL_PRODUCTS}     ${BLUE_TOP}
    automationexercise_Res.Set Quantity And Add To Cart            ${PRODUCT.edited_quantity}
    automationexercise_Res.Navigate To Cart
    automationexercise_Res.Verify Products In Cart         ${MEN_TSHIRT}           ${BLUE_TOP}
    automationexercise_Res.Verify Product Quantities In Cart       ${E2E_CART_PRODUCTS}            ${E2E_CART_QUANTITIES}
    automationexercise_Res.Attempt Checkout As Guest
    automationexercise_Res.Navigate From Cart To Signup After Block
    automationexercise_Res.Generate New Account Data
    automationexercise_Res.Register New Account        ${TEST_ACCOUNT}
    automationexercise_Res.Navigate To Cart
    automationexercise_Res.Verify Products In Cart         ${MEN_TSHIRT}           ${BLUE_TOP}
    automationexercise_Res.Verify Product Quantities In Cart       ${E2E_CART_PRODUCTS}            ${E2E_CART_QUANTITIES}
    automationexercise_Res.Navigate To Checkout Page From Cart
    automationexercise_Res.Verify Delivery Address Details          ${TEST_ACCOUNT}
    automationexercise_Res.Navigate From Checkout Page To Payment
    automationexercise_Res.Enter Credit Card Details
    automationexercise_Res.Complete Payment And Confirm Order
    automationexercise_Res.Verify Order Submitted
    [Teardown]      API_RES.Delete Account Via API









