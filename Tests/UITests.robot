*** Settings ***
Library                              SeleniumLibrary
Resource                             ../Resources/Common.robot
Resource                             ../Resources/automationexerciseRes.robot
Suite Setup                          Common.Launch Browser
#Suite Teardown                       Common.Close Browser
Test Teardown    NONE
*** Test Cases ***
Login and Logout
    [Tags]
    Login                             ${MAIN USER}
    Logout                            ${MAIN USER}

Delete an Account
    [Tags]
    Register a New Account            ${DELETED USER}    ${DATE OF BIRTH}    ${SIGNUP DETAILS}
    Delete Account                    ${DELETED USER}

Login With Invalid Credential
    [Tags]
    [Template]             automationexerciseRes.Invalid Credentials
    ${USER EMPTY EMAIL}
    ${USER EMPTY PASSWORD}
    ${DELETED USER}

Quantity Should be Editable from the Shopping Cart
    [Tags]      bug
    Login    ${MAIN USER}
    Adding a Product to the Cart from Products Page and Enter Cart         ${PRODUCT.ProductPath}
    Editing the Quantity of an Item in the Cart         ${PRODUCT.ProductPath}      ${PRODUCT.BaseQuantity}       ${PRODUCT.EditedQuantity}

Quantity Should Not Accept Negative Values
    [Tags]          bug
    Login    ${MAIN USER}
    Editing the Quantity of an Item to a minus Number and Check it in Cart           ${PRODUCT.ProductPath}          ${PRODUCT.MinusQuantity}        ${PRODUCT.MinusExpectedQuantity}


#Handle Ad
#    Sleep    2s
#    Run Keyword And Ignore Error    Click Element    xpath=//*[@id='dismiss-button']



























