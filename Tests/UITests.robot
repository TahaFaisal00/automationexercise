*** Settings ***
Library                                                                                                   SeleniumLibrary
Resource                                                                                                  ../Resources/Common.robot
Resource                                                                                                  ../Resources/automationexerciseRes.robot
Suite Setup                                                                                               Common.Launch Browser
Suite Teardown                                                                                            Common.Close Browser

*** Test Cases ***
Login and Logout
    [Tags]
    automationexerciseRes.Login                                                                           ${MAIN USER}
    automationexerciseRes.Logout                                                                          ${MAIN USER}

Delete an Account
    [Tags]
    automationexerciseRes.Register a New Account                                                          ${DELETED USER}    ${DATE OF BIRTH}    ${SIGNUP DETAILS}
    automationexerciseRes.Delete Account                                                                  ${DELETED USER}

Login With Invalid Credential
    [Tags]
    [Template]                                                                                            automationexerciseRes.Invalid Credentials
    ${USER EMPTY EMAIL}
    ${USER EMPTY PASSWORD}
    ${DELETED USER}

Quantity Should be Editable from the Shopping Cart
    [Tags]      bug
    automationexerciseRes.Login                                                                           ${MAIN USER}
    automationexerciseRes.Adding a Product to the Cart from Products Page and Enter Cart                  ${MEN TSHIRT}
    automationexerciseRes.Editing the Quantity of an Item in the Cart                                     ${MEN TSHIRT}       ${PRODUCT.BaseQuantity}       ${PRODUCT.EditedQuantity}

Quantity Should Not Accept Negative Values
    [Tags]          bug
    automationexerciseRes.Login                                                                           ${MAIN USER}
    automationexerciseRes.Editing the Quantity of an Item to a minus Number and Navigate to Cart          ${MEN TSHIRT}           ${PRODUCT.MinusQuantity}
    automationexerciseRes.Verify Cart Item And Quantity                                                   ${MEN TSHIRT}       ${PRODUCT.MinusExpectedQuantity}

Price Should Not Be Negative When Quantity Is Invalid
    [Tags]          bug
    automationexerciseRes.Login                                                                           ${MAIN USER}
    automationexerciseRes.Editing the Quantity of an Item to a minus Number and Navigate to Cart          ${MEN TSHIRT}           ${PRODUCT.MinusQuantity}
    automationexerciseRes.Verify The Total Price Valditiy in Cart                                         ${MEN TSHIRT}

Give A Product a Review
    [Tags]
    automationexerciseRes.Login                                                                           ${MAIN USER}
    automationexerciseRes.Navigate to a Product Page and Write a Review                                   ${MEN TSHIRT}       ${MAIN USER}       ${PRODUCT.Review}

Give a Comment on an Order
    [Tags]
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Adding A product to The Cart and Comment on the Order from the Checkout Page    ${MEN TSHIRT}       ${PRODUCT.Comment}

Delete an Item from the Cart
    [Tags]
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Adding A product to The Cart and Delete it                                      ${MEN TSHIRT}

Search by product name
    [Tags]
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Navigate to Products Use Search and Assert Results                              ${MEN TSHIRT}       ${MEN TSHIRT}         ${LACE TOP FOR WOMEN}       ${FROZEN TOPS FOR KIDS}     ${BLUE TOP}

Filter by category
    [Tags]
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Navigate to Products Use Category Filtering and Assert Results                  ${WOMENMENU}            ${TOPSCATEGORY}         ${BLUE TOP}       ${MEN TSHIRT}        ${FROZEN TOPS FOR KIDS}     ${EMPTY}

Filter by brand
    [Tags]
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Navigate to Products Use Brands Filtering and Assert Results                    ${ALLENSOLLYJUNIORBRAND}            ${ALLENSOLLYJUNIORPAGE}      ${FROZEN TOPS FOR KIDS}       ${LACE TOP FOR WOMEN}       ${MEN TSHIRT}      ${Blue Top}

Search with Invalid Input
    [Tags]
    automationexerciseRes.Login                                                                                                 ${MAIN USER}
    automationexerciseRes.Navigate to Products Use Search with Invalid Input and Assert Results           ${INVALIDSEARCHINPUT}         ${MEN TSHIRT}                ${LACE TOP FOR WOMEN}           ${FROZEN TOPS FOR KIDS}






E2E Guest flow Login flow






























