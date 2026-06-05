*** Settings ***
Library         SeleniumLibrary

*** Keywords ***
Enter Name on Card
    [Arguments]                       ${name}
    Input Text            xpath=//*[@data-qa='name-on-card']    ${name}

Enter Card Number
    [Arguments]                       ${number}
    Input Text            xpath=//*[@data-qa='card-number']    ${number}

Enter CVC
    [Arguments]                       ${cvc}
    Input Text            xpath=//*[@data-qa='cvc']           ${cvc}

Enter Expiration Month
    [Arguments]                       ${month}
    Input Text            xpath=//*[@data-qa='expiry-month']    ${month}

Enter Expiration Year
    [Arguments]                       ${year}
    Input Text            xpath=//*[@data-qa='expiry-year']    ${year}

Click Pay and Confirm Order Button
    Click Element    xpath=//*[contains(normalize-space() , 'Pay and Confirm Order')]

Verify Order Submitted
    Wait Until Page Contains    Your order has been placed successfully!








