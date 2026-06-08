*** Settings ***
Library         SeleniumLibrary
Library         String
Resource        ../Common.robot
*** Variables ***
#${PRODUCT_BASE} Not usable alone. always add [@class='...'] to it
${PRODUCT_BASE}                    xpath=//p[normalize-space()='{}']/ancestor::div
${PRODUCT_CARD}                    ${PRODUCT_BASE}[@class='single-products']
${OVERLAY_ADD_TO_CART}             ${PRODUCT_BASE}[@class='overlay-content']//a[contains(@class,'add-to-cart')]
${VIEW_DETAILS_LINK}               ${PRODUCT_BASE}[@class='product-image-wrapper']//a[contains(@href,'product_details')]

${AUTOMATION_EXERCISE_LOGO}         xpath=//img[@alt='Website for automation practice']
${SIGNUP_AND_LOGIN_PAGE}            xpath=//a[@href='/login']
${PRODUCTS_PAGE}                    xpath=//a[@href='/products']
${LOGOUT_BUTTON}                    xpath=//a[@href='/logout']
${DELETE_ACCOUNT_BUTTON}            xpath=//a[@href='/delete_account']
${CONTINUE_BUTTON_AFTER_DELETION}   css=[data-qa='continue-button']
${VIEW_CART_BUTTON}                 xpath=//div[@id='cartModal']//a[@href='/view_cart']

${HOME_URL}                         https://automationexercise.com/
*** Keywords ***
Verify Home Page Loaded
    Wait Until Element Is Visible    ${AUTOMATION_EXERCISE_LOGO}
    Location Should Be               ${URL}

Click Signup And Login Page Link
    Click Link                       ${SIGNUP_AND_LOGIN_PAGE}
    Wait Until Page Contains         New User Signup!

Verify Account Signed In
    [Arguments]             ${user}
    Wait Until Page Contains         Logged in as ${user}

Click Logout Link
    Click Link                       ${LOGOUT_BUTTON}

Verify Account Signed Out
    [Arguments]             ${user}
    Wait Until Page Does Not Contain         Logged in as ${user}

Add Item To Cart From Products Page
    [Arguments]                             ${product}
    ${add_to_cart}=        Format String    ${OVERLAY_ADD_TO_CART}     ${product}
    ${product_cart}=       Format String    ${PRODUCT_CARD}            ${product}
    Mouse Over                              ${product_cart}
    Wait Until Element Is Visible           ${add_to_cart}
    Click Element                           ${add_to_cart}

Verify Product Added To Cart
    Wait Until Page Contains          Your product has been added to cart

View Product Details
    [Arguments]         ${product}
    ${view_details}=     Format String    ${VIEW_DETAILS_LINK}      ${product}
    Wait Until Element Is Visible    ${view_details}
    Click Link                       ${view_details}

Click Products Page Link
    Click Link                  ${PRODUCTS_PAGE}
    Wait Until Page Contains             All Products

Click Shopping Cart Page Link
    Click Link                            ${VIEW_CART_BUTTON}
    Wait Until Page Contains             Shopping Cart

Click Delete Account Link
    Click Link                  ${DELETE_ACCOUNT_BUTTON}
    Wait Until Page Contains    Account Deleted!

Verify Account Deleted
    [Arguments]             ${user}
    Wait Until Page Contains         Account Deleted!
    Wait Until Page Contains         Your account has been permanently
    Verify Account Signed out        ${user}

Click Continue After Account Deletion
    Click Link        ${CONTINUE_BUTTON_AFTER_DELETION}
    Verify Home Page Loaded





