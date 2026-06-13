*** Settings ***
Library                                     RequestsLibrary
Resource                                    ../../Resources/API_RES.robot
Resource                                    ../../Resources/TestData.robot
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




UPDATE a User Account Details - Return 200 with Valid Required Fields
    [tags]          functional         api     put        positive        useraccounts
    &{body}=        Create Dictionary    name=Taha          email=tahaxxx@gmail.com        password=taha0         title=mr       firstname=moe       lastname=taha      address1=asdas     country=USA     state=NY     city=NY       zipcode=10010        mobile_number=2132133213
    ${response}=        PUT On Session      Auto            /api/updateAccount      data=${body}
    Status Should Be    200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    200
    Should Be Equal As Strings    ${response.json()['message']}         User updated!


UPDATE a User Account Details - Return 404 with Invalid Required Fields
    [tags]          bug         api     put        negative        useraccounts     #HTTP status should be 400 not 200
    &{body}=        Create Dictionary    name=Taha          email=xxxx        password=taha0         title=21       firstname=23       lastname=231      address1=22     country=22     state=22     city12=       zipcode=xxx        mobile_number=xxxx
    ${response}=        PUT On Session       Auto        /api/updateAccount      data=${body}            expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    404
    Should Be Equal As Strings    ${response.json()['message']}         Account not found!

UPDATE a User Account Details - Return 400 with Missing Required Fields
    [tags]          bug         api     put        negative        useraccounts     #HTTP status should be 400 not 200
    &{body}=        Create Dictionary         state=sad     city=sad       zipcode=sad        mobile_number=asd
    ${response}=        PUT On Session      Auto       /api/updateAccount         data=${body}            expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    400
    Should Contain    ${response.json()['message']}           Bad request
    Should Contain    ${response.json()['message']}           is missing in PUT request.


GET an Updated User Account Details - Returns 200 With Valid Required Fields
    [Tags]        functional         api     get        positive        useraccounts
    &{params}     Create Dictionary       email=tahaxxx@gmail.com
    ${response}=        GET On Session      Auto        /api/getUserDetailByEmail       params=${params}
    Status Should Be    200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    200
    Should Not Be Empty    ${response.json()['user']}
    
GET an Updated User Account Details - Returns 404 With Invalid Required Fields
    [Tags]          bug         api     get        negative        useraccounts     #HTTP status should be 400 not 200
    &{params}     Create Dictionary       email=xxxxxxxxxxx
    ${response}=        GET On Session      Auto        /api/getUserDetailByEmail       params=${params}        expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    404
    Should Be Equal As Strings    ${response.json()['message']}           Account not found with this email, try another email!

GET an Updated User Account Details - Returns 400 With Missing Required Fields
    [Tags]        bug         api     get        negative        useraccounts       #HTTP status should be 400 not 200
    &{params}     Create Dictionary
    ${response}=        GET On Session      Auto        /api/getUserDetailByEmail       params=${params}            expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    400
    Should Contain    ${response.json()['message']}           Bad request
    Should Contain    ${response.json()['message']}           is missing in GET request.













