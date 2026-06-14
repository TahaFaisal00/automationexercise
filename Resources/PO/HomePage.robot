*** Settings ***
Library         SeleniumLibrary
Library         String
Resource        ../Common.robot
*** Variables ***
#${PRODUCT_BASE} Not usable alone. always add [@class='...'] to it
${PRODUCT_BASE_IN_HOMEPAGE}                    xpath=//p[normalize-space()='{}']/ancestor::div
${PRODUCT_CARD}                    ${PRODUCT_BASE_IN_HOMEPAGE}\[@class='single-products']
${OVERLAY_ADD_TO_CART}             ${PRODUCT_BASE_IN_HOMEPAGE}\[@class='overlay-content']//a[contains(@class,'add-to-cart')]
${VIEW_DETAILS_LINK}               ${PRODUCT_BASE_IN_HOMEPAGE}\[@class='product-image-wrapper']//a[contains(@href,'product_details')]

${AUTOMATION_EXERCISE_LOGO}         xpath=//img[@alt='Website for automation practice']
${SIGNUP_AND_LOGIN_PAGE}            xpath=//a[@href='/login']
${PRODUCTS_PAGE}                    xpath=//a[@href='/products']
${LOGOUT_BUTTON}                    xpath=//a[@href='/logout']
${DELETE_ACCOUNT_BUTTON}            xpath=//a[@href='/delete_account']
${CONTINUE_BUTTON_AFTER_DELETION}   css=[data-qa='continue-button']
${VIEW_CART_BUTTON}                 xpath=//div[@id='cartModal']//a[@href='/view_cart']

${SHOPPING_CART_LINK}               xpath=//ul[contains(class,'navbar-nav')]//a[@href='/view_cart']

${HOME_URL}                         https://automationexercise.com/
${CONTINUE_SHOPPING}                xpath=//div[@class='modal-footer']//button[contains(@class,'close-modal')]
*** Keywords ***
Verify Home Page Loaded
    Wait Until Element Is Visible    ${AUTOMATION_EXERCISE_LOGO}
    Location Should Be               ${URL}

Click Signup And Login Page Link
    Click Link                       ${SIGNUP_AND_LOGIN_PAGE}
    Wait Until Page Contains         New User Signup!

Click Logout Link
    Click Link                       ${LOGOUT_BUTTON}

Add Item To Cart From Products Page
    [Arguments]                             ${product}
    ${add_to_cart}=        Format String    ${OVERLAY_ADD_TO_CART}     ${product}
    ${product_cart}=       Format String    ${PRODUCT_CARD}            ${product}
    Wait Until Element Is Visible           ${product_cart}
    Mouse Over                              ${product_cart}
    Wait Until Element Is Visible           ${add_to_cart}
    Click Element                           ${add_to_cart}

Verify Product Added To Cart
    Wait Until Page Contains          Your product has been added to cart

Click Continue Shopping Button
    Wait Until Element Is Visible    ${CONTINUE_SHOPPING}
    Click Element    ${CONTINUE_SHOPPING}

View Product Details
    [Arguments]         ${product}
    ${view_details}=     Format String    ${VIEW_DETAILS_LINK}      ${product}
    Wait Until Element Is Visible    ${view_details}
    Click Link                       ${view_details}

Click Products Page Link
    Click Link                  ${PRODUCTS_PAGE}
    Wait Until Page Contains             All Products

Click View Cart Link
    Wait Until Element Is Visible         ${VIEW_CART_BUTTON}
    Click Link                            ${VIEW_CART_BUTTON}
    Wait Until Page Contains             Shopping Cart

Click Shopping Cart Link
    Wait Until Element Is Visible    ${SHOPPING_CART_LINK}
    Click Link               ${SHOPPING_CART_LINK}
    Wait Until Page Contains             Shopping Cart


Click Delete Account Link
    Click Link                  ${DELETE_ACCOUNT_BUTTON}
    Wait Until Page Contains    Account Deleted!

Click Continue After Account Deletion
    Wait Until Page Contains Element    ${CONTINUE_BUTTON_AFTER_DELETION}
    Click Link        ${CONTINUE_BUTTON_AFTER_DELETION}
    Verify Home Page Loaded





