*** Settings ***
Library                                     RequestsLibrary
Library                                     String
Resource                                    ../../Resources/API_RES.robot
Resource                                    ../../Resources/API_TestData.robot
Suite Setup                                 Create Session    Auto      ${BASE_URL}

*** Test Cases ***
#name=Taha                                   email=tahaxxx@gmail.com        password=taha0
#name=DeleteMe                               email=deleteme@gmail.com        password=Delete

POST to Verify Login - Returns 200 with Valid Required Fields
    [Tags]          functional         api     post        positive        verifylogin
    &{body}=        Create Dictionary       email=tahaxxx@gmail.com       password=taha0
    ${response}=        POST On Session     Auto        /api/verifyLogin        data=${body}
    Status Should Be    200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    200
    Should Be Equal As Strings    ${response.json()['message']}         User exists!

POST to Verify Login - Returns 404 with Invalid Required Fields
    [Tags]          bug         api     post        negative        verifylogin     #HTTP status should be 404 not 200
    &{body}=        Create Dictionary       email=xxxxxxxxxx      password=xxxxxxxx
    ${response}=        POST On Session     Auto        /api/verifyLogin        data=${body}        expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    404
    Should Be Equal As Strings       ${response.json()['message']}              User not found!

POST to Verify Login of a Deleted Account - Returns 404 with Invalid Required Fields
    [Tags]          bug         api     post        negative        verifylogin     #HTTP status should be 404 not 200
    &{body}=        Create Dictionary       email=deleteme@gmail.com       password=Delete
    ${response}=        POST On Session     Auto        /api/verifyLogin        data=${body}        expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['responseCode']}    404
    Should Be Equal As Strings       ${response.json()['message']}              User not found!
POST to Verify Login - Returns 400 with Missing Required Fields
    [Tags]          bug         api     post        negative        verifylogin     #HTTP status should be 400 not 200
    &{body}=        Create Dictionary
    ${response}=        POST On Session     Auto        /api/verifyLogin        data=${body}        expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings       ${response.json()['message']}              Bad request, email or password parameter is missing in POST request.
    Should Be Equal As Strings    ${response.json()['responseCode']}    400


DELETE to Verify Login - Returns 405
    [Tags]              bug         api     delete        positive        verifylogin     #HTTP status should be 405 not 200
    ${response}=        DELETE On Session       Auto            /api/verifyLogin        expected_status=200
    Log    message=${response.json()}
    Should Be Equal As Strings    ${response.json()['message']}    This request method is not supported.
    Should Be Equal As Strings    ${response.json()['responseCode']}    405




















