*** Settings ***
Library                 SeleniumLibrary

*** Variables ***
${LOGIN_URL}                 https://automationexercise.com/login
&{MAIN_USER}                 user_name=Taha           email=taha111@gmail.com      password=taha2021       first_name=Taha      second_name=Moe
&{DELETED_USER}              user_name=Delete           email=Delete111@gmail.com        password=Delete2021
&{DATE_OF_BIRTH}             day=20            month=August          year=2000
&{SIGNUP_DETAILS}            password=Delete2021       first_name=Delete      second_name=Me      title=Mr    company=Robo    address1=1    address2=2    country=United States    state=NY    city=NY    zipcode=10001    mobile_number=71264241

&{USER_EMPTY_EMAIL}                  email=${EMPTY}              password=mmmm21
&{USER_EMPTY_PASSWORD}               email=mmmm@gmail.com        password=${EMPTY}

&{CREDIT_CARD}               name=TAHA MOE EOM       card_number=8709 9213 1245 2810            cvc=720        expiration_date_month=3     expiration_date_year=2029

&{PRODUCT}                   base_quantity=1             edited_quantity=2       minus_quantity=-5    edited_expected_quantity=2            minus_expected_quantity=1          review=This is a Good Quality T-Shirt           comment=Test comment

${MEN_TSHIRT}                       Men Tshirt
${LACE_TOP_FOR_WOMEN}               Lace Top For Women
${FROZEN_TOPS_FOR_KIDS}             Frozen Tops For Kids
${BLUE_TOP}                         Blue Top
${INVALID_SEARCH_INPUT}               xxxxxxxxx

@{ALL_PRODUCTS}         ${MEN_TSHIRT}       ${LACE_TOP_FOR_WOMEN}       ${FROZEN_TOPS_FOR_KIDS}         ${BLUE_TOP}


