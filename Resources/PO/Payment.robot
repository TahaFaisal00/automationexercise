*** Settings ***
Library         SeleniumLibrary



*** Keywords ***
Verify Payment page is Loaded
    Wait Until Page Contains    Payment

Enter Name on Card
    [Arguments]                       ${NAME}
    Input Text            xpath=//*[@data-qa='name-on-card']    ${NAME}
Enter Card Number
    [Arguments]                       ${NUMBER}
    Input Text            xpath=//*[@data-qa='card-number']    ${NUMBER}
Enter CVC
    [Arguments]                       ${CVC}
    Input Text            xpath=//*[@data-qa='cvc']           ${CVC}
Enter Expiration Month
    [Arguments]                       ${MONTH}
    Input Text            xpath=//*[@data-qa='expiry-month']    ${MONTH}
Enter Expiration Year
    [Arguments]                       ${YEAR}
    Input Text            xpath=//*[@data-qa='expiry-year']    ${YEAR}

Click Pay and Confirm Order Button
    Click Element    xpath=//*[contains(normalize-space() , 'Pay and Confirm Order')]

Verify that Order was Submitted
    Wait Until Page Contains    Your order has been placed successfully!








