*** Settings ***
Library         SeleniumLibrary
Library         String

*** Variables ***
${PRODUCT_NAME}             xpath=//p[normalize-space()='{}']
${QUANTITY_FIELD}           id=quantity

${NAME_FIELD_REVIEW}        id=name
${EMAIL_FIELD_REVIEW}       id=email
${REVIEW_FIELD}             id=review
${SUBMIT_REVIEW_BUTTON}     id=button-review

${ADD_TO_CART_FROM_PRODUCT_DETAILS}                 xpath=//button[normalize-space()='Add to cart']

${SEARCH_FIELD}               id=search_product
${SUBMIT_SEARCH_BUTTON}         id=submit_search

${PRODUCT_NAME_HEADING}          xpath=//div[@class='product-information']//h2
${PRODUCT_PAGE_URL}             https://automationexercise.com/products

${WOMEN_MENU}                       xpath=//*[@href='#Women']
${TOPS_CATEGORY}                    xpath=//*[text()='Tops ']

*** Keywords ***
Verify Products Page Loaded
    Wait Until Page Contains    All Products
    Location Should Be         ${PRODUCT_PAGE_URL}


Verify Product Details Page Loaded
    [Documentation]     Asserts the product details page shows the expected product name
    [Arguments]             ${product_name}
    Wait Until Element Is Visible    ${PRODUCT_NAME_HEADING}
    ${actual_product_name}=     Get Text    ${PRODUCT_NAME_HEADING}
    Should Be Equal As Strings    ${actual_product_name}    ${product_name}

Set Quantity
    [Arguments]                       ${quantity}
    Input Text                        ${QUANTITY_FIELD}           ${quantity}

Verify Quantity Value
    [Arguments]                       ${expected_quantity}
    ${actual_quantity}=            Get Value                 ${QUANTITY_FIELD}
    Should Be Equal As Strings    ${actual_quantity}    $${expected_quantity}

Write Review
    [Arguments]      ${username}      ${email}       ${review}
    Input Text       ${NAME_FIELD_REVIEW}         ${username}
    Input Text       ${EMAIL_FIELD_REVIEW}        ${email}
    Input Text       ${REVIEW_FIELD}              ${review}
    Click Element    ${SUBMIT_REVIEW_BUTTON}

Verify Review Submitted
    Wait Until Page Contains    Thank you for your review.

Click Add To Cart Button From Product Details Page
    Click Element    ${ADD_TO_CART_FROM_PRODUCT_DETAILS}

Verify All Products Visible
    [Arguments]         @{products}
    FOR    ${product}    IN    @{products}
        ${product_location}=     Format String    ${PRODUCT_NAME}        ${product}
        Wait Until Page Contains Element    ${product_location}
    END

Use Search Bar
    [Arguments]                    ${search}
    Input Text              ${SEARCH_FIELD}           ${search}
    Click Element           ${SUBMIT_SEARCH_BUTTON}

Choose Category From Category Menu
    [Arguments]                    ${category_menu}      ${category}
    Click Element                 ${category_menu}
    Click Link                   ${category}
    Wait Until Page Contains     ${category}

Click On Brand
    [Arguments]                 ${brand}     ${brand_page}
    Click Link                  ${brand}
    Wait Until Page Contains    ${brand_page}

Search Result Should Contain
    [Arguments]                  ${product}
    ${product_location}=         Format String    ${PRODUCT_NAME}        ${product}
    Wait Until Page Contains Element    ${product_location}

Search Result Should Not Contain
    [Arguments]         @{products}
    FOR    ${product}    IN    @{products}
        ${product_location}=     Format String    ${PRODUCT_NAME}    ${product}
        Wait Until Page Does Not Contain Element    ${product_location}
    END












