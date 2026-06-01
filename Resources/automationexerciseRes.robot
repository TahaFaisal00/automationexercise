*** Settings ***
Library         SeleniumLibrary
Resource        PO/HomePage.robot
Resource        PO/Signup&LoginPage.robot
Resource        PO/ProductsPage.robot
Resource        PO/CartPage.robot
Resource        PO/CheckoutPage.robot
Resource        PO/Payment.robot

*** Variables ***
&{MAIN USER}                 Username=Taha           Email=taha111@gmail.com      Password=taha2021       firstName=Taha      secondName=Moe
&{DELETED USER}              Username=Delete           Email=Delete111@gmail.com      Password=Delete2021       firstName=Delete      secondName=Me
&{DATE OF BIRTH}             Day=20            Month=August          Year=2000
&{SIGNUP DETAILS}            Title=Mr.   Company=Robo    Address1=1    Address2=2    Country=United States    State=NY    City=NY    Zipcode=10001    Mobile Number=71264241

&{CREDIT CARD}               Name=TAHA MOE EOM       Card Number=8709 9213 1245 2810            CVC=720        Expiration Date month=3     Expiration Date Year=2029


*** Keywords ***
Register a New Account
    [Arguments]                                     ${User}          ${Date}        ${Details}
    Navigate to Signup and Login Page
    Enter Name and Email to Signup a New User       ${User}
    Click Signup Button to Continue The Signing Up
    Verify Signup Page is Loaded
    Enter firstName, secondName and Password        ${User}
    Enter the Date of Birth                         ${Date}
    Click Sign up for our newsletter! Checkbox
    Click Receive special offers from our partners! Checkbox
    Entering the Other Details                      ${Details}
    Complete Account Creation                       ${User}


Enter Name and Email to Signup a New User
    [Arguments]              ${User}
    Enter Name to Signup a New User         ${User.Username}
    Enter Email to Signup a New User        ${User.Email}

Enter the Date of Birth
    [Arguments]             ${Date}
    Enter a Day in the Date of Birth            ${Date.Day}
    Enter a Month in the Date of Birth          ${Date.Month}
    Enter a Year in the Date of Birth           ${Date.Year}

Enter firstName, secondName and Password
    [Arguments]             ${User}
    Enter a Password        ${User.Password}
    Enter a firstName       ${User.firstName}
    Enter a lastName        ${User.secondName}

Entering the Other Details
    [Arguments]               ${Details}
    Choose a Title            ${Details.Title}
    Enter a Company Name      ${Details.Company}
    Enter Address 1           ${Details.Address1}
    Enter Address 2           ${Details.Address2}
    Enter a Country           ${Details.Country}
    Enter a State             ${Details.State}
    Enter a City              ${Details.City}
    Enter a Zipcode           ${Details.Zipcode}
    Enter Mobile Number       ${Details.Mobile Number}

Navigate to Signup and Login Page
    Verify Home Page is Loaded
    Click on Signup and Login
    Verify Signup and Login Page is Loaded

Complete Account Creation
    [Arguments]                   ${User}
    Click Create Account Button
    Verify Account is Created
    Click Continue Button
    Verify Home Page is Loaded
    Verify Account Signed in Successfully           ${User.Username}





Login
    [Arguments]                                   ${user}
    Navigate to Signup and Login Page
    Enter Login Credentials                           ${user}
    Verify Account Signed in Successfully           ${user.Username}


Enter Login Credentials
    [Arguments]         ${Credentials}
    Enter Email to Login            ${Credentials.Email}
    Enter Password to Login         ${Credentials.Password}
    Click on Login Button







