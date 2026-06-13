*** Settings ***
Library                                     RequestsLibrary
Resource                                    ../../Resources/API_RES.robot
Resource                                    ../../Resources/API_TestData.robot
Suite Setup                                 Create Session    Auto      ${BASE_URL}

*** Test Cases ***
#name=Taha          email=tahaxxx@gmail.com        password=taha0
#name=DeleteMe          email=deleteme@gmail.com        password=Delete
POST Register a New User Account - Returns 201 With Valid Required Fields
    [Tags]          bug         api     post        positive        useraccounts        #HTTP status should be 201 not 200
    &{body}=        Create Dictionary       name=DeleteMe          email=deleteme@gmail.com        password=Delete         title=mr       firstname=taha       lastname=moe      address1=here       country=usa     state=NY     city=NY       zipcode=10001        mobile_number=213213151231
    ${response}=        POST On Session     Auto          /api/createAccount        data=${body}        expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    201
    Should Be Equal As Strings    ${response.json()['message']}         User created!

POST Register an Already Existing User Account - Returns 400 With Valid Required Fields
    [Tags]          bug         api     post        negative        useraccounts          #HTTP status should be 400 not 200
    &{body}=        Create Dictionary       name=DeleteMe          email=deleteme@gmail.com        password=Delete         title=mr       firstname=taha       lastname=moe      address1=here       country=usa     state=NY     city=NY       zipcode=10001        mobile_number=213213151231
    ${response}=        POST On Session     Auto          /api/createAccount        data=${body}        expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    400
    Should Be Equal As Strings    ${response.json()['message']}         Email already exists!

POST Register a New User Account - Returns 400 With Invalid Required Fields
    [Tags]          bug         api     post        negative        useraccounts         #the site accepts any data  #HTTP status should be 400 not 200
    &{body}=        Create Dictionary       name=21          email=xxxcx        password=2         title=12313       firstname=12313       lastname=213      address1=xxxx       country=2131     state=21321     city=2132       zipcode=xxxxx        mobile_number=xxxx
    ${response}=        POST On Session     Auto          /api/createAccount             data=${body}            expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    201
    Should Be Equal As Strings    ${response.json()['message']}         User created!
POST Register a New User Account - Returns 400 With Missing Required Fields
    [Tags]          bug         api     post        negative        useraccounts         #HTTP status should be 400 not 200
    &{body}=        Create Dictionary       name=mike          email=ahmed@gmail.com        password=aaa         title=Mr
    ${response}=        POST On Session     Auto          /api/createAccount        data=${body}            expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    400
    Should Contain    ${response.json()['message']}         Bad request
    Should Contain    ${response.json()['message']}         is missing in POST request.



DELETE User Account - Returns 200 with Valid Required Fields
    [Tags]          functional         api     delete        positive        useraccounts
    &{body}=        Create Dictionary           email=deleteme@gmail.com       password=Delete
    ${response}=        DELETE On Session       Auto        /api/deleteAccount      data=${body}
    Status Should Be    200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    200
    Should Be Equal As Strings    ${response.json()['message']}         Account deleted!

DELETE an Already Deleted User Account - Returns 404 with Valid Required Fields
    [Tags]          bug         api     delete        negative        useraccounts     #HTTP status should be 404 not 200
    &{body}=        Create Dictionary           email=deleteme@gmail.com       password=Delete
    ${response}=        DELETE On Session       Auto        /api/deleteAccount      data=${body}      expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    404
    Should Be Equal As Strings    ${response.json()['message']}         Account not found!
GET a Deleted User Account Details - Returns 404 With Valid Required Fields
    [Tags]          bug         api     delete        negative        useraccounts     #HTTP status should be 404 not 200
    &{params}     Create Dictionary       email=deleteme@gmail.com
    ${response}=        GET On Session      Auto        /api/getUserDetailByEmail       params=${params}     expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    404
    Should Be Equal As Strings    ${response.json()['message']}         Account not found with this email, try another email!
DELETE User Account - Returns 404 With Invalid Required Fields
    [Tags]          bug         api     delete        negative        useraccounts         #HTTP status should be 404 not 200
    &{body}=        Create Dictionary           email=xxxxxxxxxxxxxx       password=xxxxxxxxxxxxxx
    ${response}=        DELETE On Session       Auto        /api/deleteAccount      data=${body}            expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    404
    Should Be Equal As Strings    ${response.json()['message']}         Account not found!
DELETE User Account - Returns 400 With Missing Required Fields
    [Tags]          bug         api     delete        negative        useraccounts     #HTTP status should be 400 not 200
    &{body}=        Create Dictionary
    ${response}=        DELETE On Session       Auto        /api/deleteAccount      data=${body}        expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    400
    Should Contain    ${response.json()['message']}           Bad request
    Should Contain    ${response.json()['message']}           is missing in DELETE request.




UPDATE User Account Details - Valid Fields - Return 200
    [Documentation]     Creates an account, updates a valid field, and asserts responseCode 200
    ...                with the update-success message.
    [Tags]          functional         api     put        positive        useraccounts
    [Setup]     Create Account Via API
    ${response}=        Update Account Via API      ${NAME_FIELD}      ${VALID_NAME_VALUE}
    Verify Response Code    ${response}    ${CODE_OK}
    Verify Response Message    ${response}     ${UPDATE_ACCOUNT_SUCCESS_MESSAGE}
    [Teardown]      Delete Account Via API

UPDATE User Account Details - Invalid Fields - Return 404
    [Documentation]     Documents an API defect: updating with an email that matches no account
    ...                should return HTTP 404, but the API returns HTTP 200 and reports 404 in the body.
    [Tags]          bug         api     put        negative        useraccounts
    [Setup]     Create Account Via API
    ${response}=         Update Account Via API     ${EMAIL_FIELD}      ${INVALID_EMAIL_VALUE}
    # BUG: status should be 404 but the API returns 200. Real code is in the body.
    Status Should Be    ${CODE_OK}      ${response}
    Verify Response Code    ${response}       ${CODE_NOT_FOUND}
    Verify Response Message    ${response}     ${ACCOUNT_NOT_FOUND_MESSAGE}
    [Teardown]      Delete Account Via API

UPDATE User Account Details - Missing Fields - Return 400
    [Documentation]     Documents an API defect: an update missing the required field should return
    ...                HTTP 400, but the API returns HTTP 200 and reports 400 in the body.
    [Tags]          bug         api     put        negative        useraccounts
    [Setup]     Create Account Via API
    ${response}=        Attempt Update Account With Missing Field Via API       ${EMAIL_FIELD}
    # BUG: status should be 400 but the API return 200. Real code is in the body.
    Status Should Be    ${CODE_OK}      ${response}
    Verify Response Code    ${response}       ${CODE_BAD_REQUEST}
    # Todo: run the test and check log for the required field message in response
    Verify Response Message Contains        ${response}       ${BAD_REQUEST_MESSAGE}
    Verify Response Message Contains         ${response}         ${MISSING_FIELD_IN_PUT_MESSAGE}
    [Teardown]      Delete Account Via API


GET User Details - Valid Fields - Returns 200
    [Documentation]     Creates an account, retrieves the user details, and asserts responseCode
    ...                200 with a non-empty user object.
    [Tags]        functional         api     get        positive        useraccounts
    [Setup]     Create Account Via API
    ${response}=       Get User Details Via API
    Verify Response Code    ${response}    ${CODE_OK}
    Verify Response Field Not Empty    ${response}    ${RESPONSE_FIELD_USER}
    [Teardown]      Delete Account Via API

GET User Details - Invalid Fields - Returns 404
    [Documentation]         Documents an API defect: requesting details for a non-existent email should
    ...                return HTTP 404, but the API returns HTTP 200 and reports 404 in the body.
    [Tags]          bug         api     get        negative        useraccounts
    [Setup]     Create Account Via API
    ${response}=        Attempt Get User Details With Invalid Field Via API         ${EMAIL_FIELD}      ${INVALID_EMAIL_VALUE}
    # BUG: status should be 404 but API return 200. Real code is in the body
    Status Should Be    ${CODE_OK}      ${response}
    Verify Response Code    ${response}    ${CODE_NOT_FOUND}
    Verify Response Message    ${response}    ${GET_ACCOUNT_NOT_FOUND_MESSAGE}
    [Teardown]      Delete Account Via API

GET User Details - Missing Fields - Returns 400
    [Documentation]     Documents an API defect: a request missing the required field should return
    ...                HTTP 400, but the API returns HTTP 200 and reports 400 in the body.
    [Tags]        bug         api     get        negative        useraccounts
    [Setup]     Create Account Via API
    ${response}=       Attempt Get User Details With Missing Field Via API          ${EMAIL_FIELD}
    # BUG: status should be 400 but API return 200. Real code is in the body
    Status Should Be    ${CODE_OK}      ${response}
    Verify Response Code    ${response}    ${CODE_BAD_REQUEST}
    # Todo: run the test and check log for the required field message in response
    Verify Response Message Contains    ${response}     ${BAD_REQUEST_MESSAGE}
    Verify Response Message Contains    ${response}     ${MISSING_FIELD_IN_GET_MESSAGE}
    [Teardown]      Delete Account Via API














