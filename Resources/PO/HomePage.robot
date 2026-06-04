*** Settings ***
Library         SeleniumLibrary



*** Keywords ***
Verify Home Page is Loaded
    Wait Until Element Is Visible    xpath=//*[@alt='Website for automation practice']
    Wait Until Page Contains         Category

Click on Signup and Login
    Click link                       xpath=//*[@href='/login']

Verify Account Signed in Successfully
    [Arguments]             ${User}
    Wait Until Page Contains         Logged in as ${User}

Click on Logout
    Click Link                    xpath=//*[text()=' Logout']

Verify Account Signed Out Successfully
    [Arguments]             ${User}
    Page Should Not Contain         Logged in as ${User}



Hover And Click Add to Cart Button
    [Arguments]                 ${ProductPath}
    Mouse Over                   xpath=//*[text()='${ProductPath}']
    Click Element                xpath=//*[text()='${ProductPath}']/ancestor::div[@class='overlay-content']//*[@class='btn btn-default add-to-cart']
Verify Product Added to Cart
    Page Should Contain      Your product has been added to cart


View a Product Details
    [Arguments]         ${ProductPath}
    Wait Until Element Is Visible    xpath=//*[text()='${ProductPath}']
    Click Link                       xpath=//*[text()='${ProductPath}']/ancestor::div[@class='product-image-wrapper']//a[contains(@href,'product_details')]


Navigate to Products
    Click Link                  xpath=//*[@href='/products']



Navigate to the Shopping Cart
    Click Link                            xpath=//*[@id='cartModal']//a[@href='/view_cart']

Click Delete Account
    Click Link                  xpath=//*[text()=' Delete Account']

Verify Account Deleted
    Wait Until Page Contains    Account Deleted!
    Page Should Contain         Your account has been permanently

