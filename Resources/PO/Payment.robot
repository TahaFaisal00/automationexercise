*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${NAME_ON_CARD_FIELD}       css=[data-qa='name-on-card']
${CARD_NUMBER_FIELD}        css=[data-qa='card-number']
${CVC_FIELD}                css=[data-qa='cvc']
${EXPIRY_MONTH_FIELD}       css=[data-qa='expiry-month']
${EXPIRY_YEAR_FIELD}        css=[data-qa='expiry-year']
${CONFIRM_ORDER_BUTTON}     css=[data-qa='pay-button']
*** Keywords ***
Enter Name On Card
    [Arguments]                       ${name}
    Input Text            ${NAME_ON_CARD_FIELD}     ${name}

Enter Card Number
    [Arguments]                       ${number}
    Input Text            ${CARD_NUMBER_FIELD}    ${number}

Enter CVC
    [Arguments]                       ${cvc}
    Input Text            ${CVC_FIELD}           ${cvc}

Enter Expiry Month
    [Arguments]                       ${month}
    Input Text            ${EXPIRY_MONTH_FIELD}     ${month}

Enter Expiry Year
    [Arguments]                       ${year}
    Input Text            ${EXPIRY_YEAR_FIELD}    ${year}

Click Pay And Confirm Order Button
    Click Element          ${CONFIRM_ORDER_BUTTON}

Verify Order Submitted
    Wait Until Page Contains    Your order has been placed successfully!








