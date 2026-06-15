*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${NAME_ON_CARD_FIELD}               css=[data-qa='name-on-card']
${CARD_NUMBER_FIELD}                css=[data-qa='card-number']
${CVC_FIELD}                        css=[data-qa='cvc']
${EXPIRY_MONTH_FIELD}               css=[data-qa='expiry-month']
${EXPIRY_YEAR_FIELD}                css=[data-qa='expiry-year']
${CONFIRM_ORDER_BUTTON}             css=[data-qa='pay-button']

${PAYMENT_URL}                      https://automationexercise.com/payment

${ORDER_PLACED_HEADER}              css=[data-qa='order-placed']

${CONTINUE_BUTTON_ORDER_PLACED}     css=[data-qa='continue-button']
${DOWNLOAD_INVOICE_BUTTON}          xpath=//a[contains(@href,'/download_invoice')]


*** Keywords ***
Verify Payment Page Loaded
    Wait Until Page Contains    Payment
    Location Should Be    ${PAYMENT_URL}

Enter Name On Card
    [Arguments]    ${name}
    Input Text    ${NAME_ON_CARD_FIELD}    ${name}

Enter Card Number
    [Arguments]    ${number}
    Input Text    ${CARD_NUMBER_FIELD}    ${number}

Enter CVC
    [Arguments]    ${cvc}
    Input Text    ${CVC_FIELD}    ${cvc}

Enter Expiry Month
    [Arguments]    ${month}
    Input Text    ${EXPIRY_MONTH_FIELD}    ${month}

Enter Expiry Year
    [Arguments]    ${year}
    Input Text    ${EXPIRY_YEAR_FIELD}    ${year}

Click Pay And Confirm Order Button
    Wait Until Element Is Visible    ${CONFIRM_ORDER_BUTTON}
    Click Element    ${CONFIRM_ORDER_BUTTON}

Click Continue After Order Placement
    Wait Until Element Is Visible    ${CONTINUE_BUTTON_ORDER_PLACED}
    Click Element    ${CONTINUE_BUTTON_ORDER_PLACED}

Click Download Invoice Button
    Wait Until Element Is Visible    ${DOWNLOAD_INVOICE_BUTTON}
    Click Element    ${DOWNLOAD_INVOICE_BUTTON}
