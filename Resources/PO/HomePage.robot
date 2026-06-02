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
    Click Element                    xpath=//*[text()='Logout']

Verify Account Signed Out Successfully
    [Arguments]             ${User}
    Page Should Not Contain         Logged in as ${User}




Click Add to Cart Button
    Click Element                xpath=//*[text()='Men Tshirt' and text()='Add to cart']
Verify Product Added to Cart
    Alert Should Be Present      Your product has been added to cart


View a Product Details
    Wait Until Element Is Visible    xpath=//*[text()='Men Tshirt']
    Click Link                       xpath=//*[text()='Men Tshirt' and text()='View Product']


Navigate to the Shopping Cart
    Click Link                            xpath=//*[text()='Cart']

