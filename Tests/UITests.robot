*** Settings ***
Documentation             Using Store Tests in automationexercise.com - covers accounts, adding products, editing, submitting and deleting them. Invalid input cases tagged 'negative'. Tests documenting site defects tagged 'bug'.
Library                                                                                                   SeleniumLibrary
Resource                                                                                                  ../Resources/Common.robot
Resource                                                                                                  ../Resources/TestData.robot
Resource                                                                                                  ../Resources/automationexercise_Res.robot
Suite Setup                                                                                               Common.Launch Browser
Suite Teardown                                                                                            Common.Shutdown Browser
Test Setup                                                                                                Common.Test Isolation Setup

*** Test Cases ***
Login And Logout
    [Documentation]       Logs in with the existing fixture account, then logs out —
    ...                   verifies the login and logout features work.
    [Tags]                functionality      ui          positive
    automationexercise_Res.Log In And Verify                                                               ${MAIN_USER.email}   ${MAIN_USER.password}     ${MAIN_USER.user_name}
    automationexercise_Res.Log Out And Verify                                                              ${MAIN_USER.user_name}

Register And Delete Account
    [Documentation]       Registers a new account, deletes it, then confirms the
    ...                   deleted account can no longer log in.
    [Tags]                functionality      ui          negative
    automationexercise_Res.Generate New Account Data
    automationexercise_Res.Register New Account                                                            ${TEST_ACCOUNT}
    automationexercise_Res.Delete Account                                                                  ${TEST_ACCOUNT.user_name}
    automationexercise_Res.Verify Login Fails                                                              ${TEST_ACCOUNT}
    [Teardown]    API_RES.Delete Account Via API                                                           ${TEST_ACCOUNT}

Login With Invalid Credential
    [Documentation]       Guest Logging in with multiple Invalid Scenarios including no email, no password and non existing user.Verify Login feature functionality
    [Tags]                functionality     ui          negative
    [Template]                                                                                            automationexercise_Res.Verify Login Fails
    ${DELETED_USER}
    ${USER_EMPTY_EMAIL}
    ${USER_EMPTY_PASSWORD}

Cart Quantity Field Is Not Editable
    [Documentation]       Quantity in cart should be editable but is read-only
    [Tags]                bug               ui          negative
    automationexercise_Res.Add Product To Cart And Open Cart                  ${ALL_PRODUCTS}     ${MEN_TSHIRT}
    automationexercise_Res.Verify Products In Cart                                ${MEN_TSHIRT}
    automationexercise_Res.Verify Product Quantities In Cart                             ${MEN_TSHIRT}       ${PRODUCT.base_quantity}
    automationexercise_Res.Editing Quantity Of Product In Cart                    ${MEN_TSHIRT}

Quantity Accepts Negative Values
    [Documentation]       Sets a negative quantity on the product details page and verifies the page accepts it. Documents the negative-quantity bug.
    [Tags]                bug               ui          negative
    automationexercise_Res.Navigate To Product Details Page                                 ${ALL_PRODUCTS}           ${MEN_TSHIRT}
    automationexercise_Res.Set And Verify Quantity To Negative Number                       ${PRODUCT.minus_quantity}           ${PRODUCT.minus_quantity}


Price Is Negative When Quantity Is Negative
    [Documentation]       Adds a product to the cart with a negative quantity and verifies the cart shows a negative price. Documents the negative-quantity bug.
    [Tags]                bug               ui          negative
    [Setup]         API_RES.Create Account Via API
    automationexercise_Res.Log In And Verify          ${TEST_ACCOUNT.email}    ${TEST_ACCOUNT.password}    ${TEST_ACCOUNT.user_name}
    automationexercise_Res.Navigate To Product Details Page                                 ${ALL_PRODUCTS}           ${MEN_TSHIRT}
    automationexercise_Res.Set Quantity And Add To Cart                                        ${PRODUCT.minus_quantity}
    automationexercise_Res.Navigate To Cart
    automationexercise_Res.Verify Products In Cart                                     ${MEN_TSHIRT}
    automationexercise_Res.Verify Product Quantities In Cart                          ${MEN_TSHIRT}           ${PRODUCT.minus_quantity}
    automationexercise_Res.Verify Product Total Price In Cart Is Negative                    ${MEN_TSHIRT}
    [Teardown]      API_RES.Delete Account Via API

Give Product Review
    [Documentation]      Submits a review for a product and verifies the review feature works.
    [Tags]               functionality      ui          positive
    automationexercise_Res.Navigate To Product Details Page                                               ${ALL_PRODUCTS}     ${MEN_TSHIRT}
    automationexercise_Res.Submit Product Review                                                          ${MAIN_USER}        ${PRODUCT}

Delete Item From Cart
    [Documentation]       Adds an item to the cart, deletes it, and verifies the delete works.
    [Tags]                functionality     ui          positive
    automationexercise_Res.Add Product To Cart And Open Cart                  ${ALL_PRODUCTS}     ${MEN_TSHIRT}
    automationexercise_Res.Verify Products In Cart                                ${MEN_TSHIRT}
    automationexercise_Res.Verify Product Quantities In Cart                             ${MEN_TSHIRT}       ${PRODUCT.base_quantity}
    automationexercise_Res.Delete Product From Shopping Cart                      ${MEN_TSHIRT}

Search By Product Name
    [Documentation]       Searches for a specific product and verifies only the
    ...                   matching product appears in the results.
    [Tags]                functionality     ui          positive
    automationexercise_Res.Search Products And Verify Results                                              ${ALL_PRODUCTS}       ${MEN_TSHIRT}         ${LACE_TOP_FOR_WOMEN}       ${FROZEN_TOPS_FOR_KIDS}     ${BLUE_TOP}

Filter By Category
    [Documentation]       Filters products by category and verifies only the matching products appear.
    [Tags]                functionality     ui          positive
    automationexercise_Res.Choose Category And Verify Results                                              ${ALL_PRODUCTS}       ${WOMEN_MENU}       ${TOPS_CATEGORY}        ${BLUE_TOP}       ${MEN_TSHIRT}          ${FROZEN_TOPS_FOR_KIDS}

Filter By Brand
    [Documentation]       user filter products shown by brand. Verifys filtering feature functionality.
    [Tags]                functionality     ui          positive
    automationexercise_Res.Choose Brand Filter And Verify Results                             ${ALL_PRODUCTS}         ${ALLEN_SOLLY_JUNIOR_BRAND}        ${ALLEN_SOLLY_JUNIOR_PAGE}      ${FROZEN_TOPS_FOR_KIDS}       ${MEN_TSHIRT}         ${LACE_TOP_FOR_WOMEN}      ${BLUE_TOP}

Search Invalid Input
    [Documentation]       user use search feature for invalid or non existing item. verify Searching feature functionality.
    [Tags]                functionality     ui          negative
    automationexercise_Res.Search Products And Verify Results                                              ${ALL_PRODUCTS}         ${INVALID_SEARCH_INPUT}         ${MEN_TSHIRT}         ${LACE_TOP_FOR_WOMEN}       ${FROZEN_TOPS_FOR_KIDS}     ${BLUE_TOP}






E2E Guest flow Login flow






























