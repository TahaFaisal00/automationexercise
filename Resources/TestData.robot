*** Settings ***
Library                 SeleniumLibrary

*** Variables ***
${LOGIN URL}                 https://automationexercise.com/login
&{MAIN USER}                 Username=Taha           Email=taha111@gmail.com      Password=taha2021       firstName=Taha      secondName=Moe
&{DELETED USER}              Username=Delete           Email=Delete111@gmail.com      Password=Delete2021       firstName=Delete      secondName=Me
&{DATE OF BIRTH}             Day=20            Month=August          Year=2000
&{SIGNUP DETAILS}            Title=Mr    Company=Robo    Address1=1    Address2=2    Country=United States    State=NY    City=NY    Zipcode=10001    MobileNumber=71264241

&{USER EMPTY EMAIL}                  Email=${EMPTY}              Password=mmmm21
&{USER EMPTY PASSWORD}               Email=mmmm@gmail.com        Password=${EMPTY}

&{CREDIT CARD}               Name=TAHA MOE EOM       CardNumber=8709 9213 1245 2810            CVC=720        ExpirationDatemonth=3     ExpirationDateYear=2029

&{PRODUCT}                   BaseQuantity=1             EditedQuantity=2       MinusQuantity=-5    EditedExpectedQuantity=2            MinusExpectedQuantity=1          Review=This is a Good Quality T-Shirt           Comment=Test comment

${MEN TSHIRT}                       Men Tshirt
${LACE TOP FOR WOMEN}               Lace Top For Women
${FROZEN TOPS FOR KIDS}             Frozen Tops For Kids
${BLUE TOP}                         Blue Top
${INVALIDSEARCHINPUT}               xxxxxxxxx

${WOMENMENU}                       xpath=//*[@href='#Women']
${TOPSCATEGORY}                    xpath=//*[text()='Tops ']
${WOMENTOPSPAGE}                   Women - Tops Products
${ALLENSOLLYJUNIORBRAND}           xpath=//*[@href='/brand_products/Allen Solly Junior']
${ALLENSOLLYJUNIORPAGE}            Brand - Allen Solly Junior Products