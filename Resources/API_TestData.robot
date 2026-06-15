*** Variables ***
${BASE_URL}                                                 https://automationexercise.com
${ALIAS}                                                    Auto

${POST_ACCOUNT_API}                                         /api/createAccount
${DELETE_ACCOUNT_API}                                       /api/deleteAccount

${USER_DETAIL_BY_EMAIL_API}                                 /api/getUserDetailByEmail
${UPDATE_ACCOUNT_API}                                       /api/updateAccount

${VERIFY_LOGIN_API}                                         /api/verifyLogin

${BRANDS_LIST_API}                                          /api/brandsList

${SEARCH_PRODUCT_API}                                       /api/searchProduct

${PRODUCTS_LIST_API}                                        /api/productsList

${COUNTRY}                                                  Test
${TITLE}                                                    Mr

${CODE_CREATED}                                             201
${CODE_BAD_REQUEST}                                         400
${CODE_NOT_FOUND}                                           404
${CODE_OK}                                                  200
${CODE_METHOD_NOT_ALLOWED}                                  405

${CREATE_ACCOUNT_SUCCESS_MESSAGE}                           User created!
${UPDATE_ACCOUNT_SUCCESS_MESSAGE}                           User updated!
${DELETE_ACCOUNT_SUCCESS_MESSAGE}                           Account deleted!
${BAD_REQUEST_MESSAGE}                                      Bad request
${CREATE_ACCOUNT_DUPLICATE_EMAIL_MESSAGE}                   Email already exists!
${VERIFY_LOGIN_SUCCESS_MESSAGE}                             User exists!

${VERIFY_LOGIN_USER_NOT_FOUND_MESSAGE}                      User not found!
${VERIFY_LOGIN_MISSING_EMAIL_OR_PASSWORD_FIELD_MESSAGE}     email or password parameter

${MISSING_FIELD_IN_POST_MESSAGE}                            is missing in POST request.
${MISSING_FIELD_IN_DELETE_MESSAGE}                          is missing in DELETE request.
${MISSING_FIELD_IN_PUT_MESSAGE}                             is missing in PUT request.
${MISSING_FIELD_IN_GET_MESSAGE}                             is missing in GET request.
${MISSING_FIRST_NAME_FIELD_MESSAGE}                         firstname parameter
${MISSING_EMAIL_FIELD_MESSAGE}                              email parameter
${SEARCH_PRODUCT_MISSING_FIELD_MESSAGE}                     search_product parameter

${ACCOUNT_NOT_FOUND_MESSAGE}                                Account not found!
${GET_ACCOUNT_NOT_FOUND_MESSAGE}                            Account not found with this email, try another email!

${NOT_SUPPORTED_MESSAGE}                                    This request method is not supported.

${RESPONSE_FIELD_PRODUCTS_LIST}                             'products'
${RESPONSE_FIELD_BRANDS_LIST}                               'brands'
${RESPONSE_FIELD_USER}                                      'user'

${SHIRT}                                                    shirt
${NON_EXISTENT_PRODUCT}                                     xxxxxxxxx
${SEARCH_FIELD}                                             search_product

${EMAIL_FIELD}                                              email
${INVALID_EMAIL_VALUE}                                      xxx
${NAME_FIELD}                                               name
${VALID_NAME_VALUE}                                         Mike
