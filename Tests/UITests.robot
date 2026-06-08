*** Settings ***
Documentation             Using Store Tests in automationexercise.com - covers accounts, adding products, editing, submitting and deleting them. Invalid input cases tagged 'negative'. Tests documenting site defects tagged 'bug'.
Library                                                                                                   SeleniumLibrary
Resource                                                                                                  ../Resources/Common.robot
Resource                                                                                                  ../Resources/TestData.robot
Resource                                                                                                  ../Resources/automationexerciseRes.robot
Suite Setup                                                                                               Common.Launch Browser
Suite Teardown                                                                                            Common.Shutdown Browser
Test Setup                                                                                                Common.Test Isolation Setup

*** Test Cases ***
Login And Logout
    [Documentation]       Guest logging in with already created account credentials Then log out. Verify Login and logout features functionality
    [Tags]                functionality      ui          positive
    automationexerciseRes.Login                                                                           ${MAIN USER}
    automationexerciseRes.Logout                                                                          ${MAIN USER}

Delete Account
    [Documentation]       Guest creates a new account and delete it then try to log into it. Verify Signin and deletion Features functionality
    [Tags]                functionality      ui          positive
    automationexerciseRes.Register a New Account                                                          ${DELETED USER}    ${DATE OF BIRTH}    ${SIGNUP DETAILS}
    automationexerciseRes.Delete Account                                                                  ${DELETED USER}
    automationexerciseRes.Invalid Credentials                                                             ${DELETED_USER}

Login With Invalid Credential
    [Documentation]       Guest Logging in with multiple Invalid Scenarios including no email, no password and non existing user.Verify Login feature functionality
    [Tags]                functionality     ui          negative
    [Template]                                                                                            automationexerciseRes.Invalid Credentials
    ${USER EMPTY EMAIL}
    ${USER EMPTY PASSWORD}
    ${DELETED USER}

Quantity Should Be Editable From Shopping Cart
    [Documentation]       User add product to cart and edit its quantity from cart. Verify item quantity isn't editable from cart.
    [Tags]                bug               ui          negative
    automationexerciseRes.Login                                                                           ${MAIN USER}
    automationexerciseRes.Adding a Product to the Cart from Products Page and Enter Cart                  ${MEN TSHIRT}
    automationexerciseRes.Editing the Quantity of an Item in the Cart                                     ${MEN TSHIRT}       ${PRODUCT.BaseQuantity}       ${PRODUCT.EditedQuantity}

Quantity Should Not Accept Negative Values
    [Documentation]       User add item to cart with a negative quantity then check quantity in cart. Verify cart accept negative quantity.
    [Tags]                bug               ui          negative
    automationexerciseRes.Login                                                                           ${MAIN USER}
    automationexerciseRes.Editing the Quantity of an Item to a minus Number and Navigate to Cart          ${MEN TSHIRT}           ${PRODUCT.MinusQuantity}
    automationexerciseRes.Verify Cart Item And Quantity                                                   ${MEN TSHIRT}       ${PRODUCT.MinusExpectedQuantity}

Price Should Not Be Negative When Quantity Invalid
    [Documentation]       User add item to cart with a negative quantity then check the price in cart. Verify cart show negative prices.
    [Tags]                bug               ui          negative
    automationexerciseRes.Login                                                                           ${MAIN USER}
    automationexerciseRes.Editing the Quantity of an Item to a minus Number and Navigate to Cart          ${MEN TSHIRT}           ${PRODUCT.MinusQuantity}
    automationexerciseRes.Verify The Total Price Valditiy in Cart                                         ${MEN TSHIRT}

Give Product Review
    [Documentation]      User give review for item. Verify review feature functionality.
    [Tags]               functionality      ui          positive
    automationexerciseRes.Login                                                                           ${MAIN USER}
    automationexerciseRes.Navigate to a Product Page and Write a Review                                   ${MEN TSHIRT}       ${MAIN USER}       ${PRODUCT.Review}

Give Comment On Order
    [Documentation]       User add item to cart and submit his order then Comment on it. Verify order comment feature functionality.
    [Tags]                functionality     ui          positive
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Adding A product to The Cart and Comment on the Order from the Checkout Page    ${MEN TSHIRT}       ${PRODUCT.Comment}

Delete Item From Cart
    [Documentation]       User add item to cart then Delete it from cart. Verify Deletion feature functionality.
    [Tags]                functionality     ui          positive
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Adding A product to The Cart and Delete it                                      ${MEN TSHIRT}

Search By Product Name
    [Documentation]       User use search feature for a specific item. verify Searching feature functionality.
    [Tags]                functionality     ui          positive
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Navigate to Products Use Search and Assert Results                              ${MEN TSHIRT}       ${MEN TSHIRT}         ${LACE TOP FOR WOMEN}       ${FROZEN TOPS FOR KIDS}     ${BLUE TOP}

Filter By Category
    [Documentation]       user filter products shown by category. Verifys filtering feature functionality.
    [Tags]                functionality     ui          positive
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Navigate to Products Use Category Filtering and Assert Results                  ${WOMENMENU}            ${TOPSCATEGORY}         ${BLUE TOP}       ${MEN TSHIRT}        ${FROZEN TOPS FOR KIDS}     ${EMPTY}

Filter By Brand
    [Documentation]       user filter products shown by brand. Verifys filtering feature functionality.
    [Tags]                functionality     ui          positive
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Navigate to Products Use Brands Filtering and Assert Results                    ${ALLENSOLLYJUNIORBRAND}            ${ALLENSOLLYJUNIORPAGE}      ${FROZEN TOPS FOR KIDS}       ${LACE TOP FOR WOMEN}       ${MEN TSHIRT}      ${Blue Top}

Search Invalid Input
    [Documentation]       user use search feature for invalid or non existing item. verify Searching feature functionality.
    [Tags]                functionality     ui          negative
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Navigate to Products Use Search with Invalid Input and Assert Results           ${INVALIDSEARCHINPUT}         ${MEN TSHIRT}                ${LACE TOP FOR WOMEN}           ${FROZEN TOPS FOR KIDS}






E2E Guest flow Login flow






























