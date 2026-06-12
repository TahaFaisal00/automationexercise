*** Variables ***
${BASE_URL}                                         https://automationexercise.com
${ALIAS}                                            Auto
${REGISTER_ACCOUNT_API}                             /api/createAccount
${DELETE_ACCOUNT_API}                               /api/deleteAccount

${COUNTRY}                                          Test
${TITLE}                                            Mr

${CODE_CREATED}                                     201
${CODE_BAD_REQUEST}                                 400
${CODE_NOT_FOUND}                                   404
${CREATE_ACCOUNT_SUCCESS_MESSAGE}                   User created!
${UPDATE_ACCOUNT_SUCCESS _MESSAGE}                  User updated!
${DELETE_ACCOUNT_SUCCESS _MESSAGE}                  Account deleted!
${BAD_REQUEST_MESSAGE}                              Bad request
${CREATE_ACCOUNT_DUPLICATE_EMAIL_MESSAGE}           Email already exists!
${MISSING_FIELD _IN_POST_MESSAGE}                   is missing in POST request.
${MISSING_FIELD_IN_DELETE_MESSAGE}                  is missing in DELETE request.
${MISSING_FIELD_IN_PUT_MESSAGE}                     is missing in PUT request.
${MISSING_FIELD_IN_GET_MESSAGE}                     is missing in GET request.
${MISSING_FIRST_NAME_FIELD_MESSAGE}                 firstname parameter
${MISSING_EMAIL_FILED_MESSAGE}                      email parameter
${DELETE_ACCOUNT_NOT_FOUND_MESSAGE}                 Account not found!
${GET_ACCOUNT_NOT_FOUND_MESSAGE}                    Account not found with this email, try another email!












