*** Settings ***
Documentation       UI-driven end-to-end purchase journeys (registered + guest-to-registered).
Library             SeleniumLibrary
Resource            ../../Resources/Common.robot
Resource            ../../Resources/TestData.robot
Resource            ../../Resources/automationexercise_Res.robot

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
    Add Product To Cart And Continue Shopping       ${ALL_PRODUCTS}     ${MEN_TSHIRT}
    Navigate To Product Details Page            ${ALL_PRODUCTS}     ${BLUE_TOP}
    Set Quantity And Add To Cart            ${PRODUCT.edited_quantity}
    Navigate To Cart
    Verify Products In Cart         ${MEN_TSHIRT}           ${BLUE_TOP}
    Verify Product Quantities In Cart       ${E2E_CART_PRODUCTS}            ${E2E_CART_QUANTITIES}
    Navigate To Checkout Page From Cart
    Verify Delivery Address Details          ${TEST_ACCOUNT}
    Navigate From Checkout Page To Payment
    Enter Credit Card Details
    Complete Payment And Confirm Order
    Verify Order Submitted
