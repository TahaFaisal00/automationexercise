*** Settings ***
Library         SeleniumLibrary



*** Keywords ***
Verify Home Page Loaded
    Wait Until Element Is Visible    xpath=//*[@alt='Website for automation practice']
    Wait Until Page Contains         Category

Navigate to Signup and Login Page
    Click link                       xpath=//*[@href='/login']
    Wait Until Page Contains         New User Signup!

Verify Account Signed in
    [Arguments]             ${user}
    Wait Until Page Contains         Logged in as ${user}

Click Logout
    [Arguments]             ${user}
    Click Link                    xpath=//*[contains(normalize-space() , 'Logout')]

Verify Account Signed out
    [Arguments]             ${user}
    Page Should Not Contain         Logged in as ${user}

Add Item to Cart From Products Page
    [Arguments]                 ${product}
    Mouse Over                   xpath=//*[contains(normalize-space() , '${product}')]
    Click Element                xpath=//*[contains(normalize-space() , '${product}')]/ancestor::div[@class='overlay-content']//*[@class='btn btn-default add-to-cart']

Verify Product Added to Cart
    Page Should Contain          Your product has been added to cart

View Product Details
    [Arguments]         ${product}
    Wait Until Element Is Visible    xpath=//*[contains(normalize-space() , '${product}')]
    Click Link                       xpath=//*[contains(normalize-space() , '${product}')]/ancestor::div[@class='product-image-wrapper']//a[contains(@href,'product_details')]

Navigate to Products
    Click Link                  xpath=//*[@href='/products']
    Wait Until Page Contains             All Products

Navigate to Shopping Cart
    Click Link                            xpath=//*[@id='cartModal']//a[@href='/view_cart']
    Wait Until Page Contains      Shopping Cart

Click Delete Account
    Click Link                  xpath=//*[contains(normalize-space() , 'Delete Account')]
    Wait Until Page Contains    Account Deleted!

Verify Account Deleted
    [Arguments]             ${user}
    Wait Until Page Contains         Account Deleted!
    Wait Until Page Contains         Your account has been permanently
    Verify Account Signed out        ${user}

Click Continue After Account Deletion
    Click Link        xpath=//*[@data-qa='continue-button']
    Verify Home Page Loaded





