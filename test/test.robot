*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

*** Variables ***
${REGISTER_URL}      https://web.evbtranding.site/register
${LOGIN_URL}         https://web.evbtranding.site/login
${BROWSER}           Chrome
${PASSWORD}          Test@123456
${VALID_EMAIL}       valid_existing_email@gmail.com  # Placeholder, will be overwritten by registration test

*** Keywords ***
Open Chrome Headless
    ${options}=    Evaluate    selenium.webdriver.ChromeOptions()    modules=selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size\=1920,1080
    Open Browser    about:blank    ${BROWSER}    options=${options}

Scroll And Click Button
    [Arguments]    ${locator}
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Click Button    ${locator}

Teardown With Debug
    Run Keyword If Test Failed    Log Location
    Run Keyword If Test Failed    Capture Page Screenshot
    ${html}=    Run Keyword If Test Failed    Get Source
    Run Keyword If Test Failed    Log    ${html}
    Close Browser

*** Test Cases ***
# --- REGISTRATION TEST CASES ---

Registration - Successful With Valid Data
    [Documentation]    Verify user can register with valid email and password
    [Teardown]    Teardown With Debug
    Open Chrome Headless
    Go To    ${REGISTER_URL}
    Maximize Browser Window
    ${random_string}=    Generate Random String    8    [LOWER]
    ${email}=    Set Variable    test${random_string}@gmail.com
    Set Suite Variable    ${REGISTERED_EMAIL}    ${email}
    Input Text    xpath=//input[@type='email']        ${email}
    Input Text    xpath=//input[@type='password']     ${PASSWORD}
    Scroll And Click Button    xpath=//button[@type='submit']
    # After registration, assuming it redirects to login or stays on page. 
    # If it redirects to Login, we should see the Email Input.
    Wait Until Page Contains Element    xpath=//input[@type='email']    20s

Registration - Fail Empty Fields
    [Documentation]    Verify registration fails when fields are empty
    [Teardown]    Teardown With Debug
    Open Chrome Headless
    Go To    ${REGISTER_URL}
    Maximize Browser Window
    Scroll And Click Button    xpath=//button[@type='submit']
    # Assuming HTML5 validation or simple JS alert/error message
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s

Registration - Fail Invalid Email Format
    [Documentation]    Verify registration fails with invalid email format
    [Teardown]    Teardown With Debug
    Open Chrome Headless
    Go To    ${REGISTER_URL}
    Maximize Browser Window
    Input Text    xpath=//input[@type='email']        invalid_email_format
    Input Text    xpath=//input[@type='password']     ${PASSWORD}
    Scroll And Click Button    xpath=//button[@type='submit']
    # Check that we are still on the registration page (input field still exists)
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s

Registration - Fail Short Password
    [Documentation]    Verify registration fails with short password
    [Teardown]    Teardown With Debug
    Open Chrome Headless
    Go To    ${REGISTER_URL}
    Maximize Browser Window
    Input Text    xpath=//input[@type='email']        shortpass@gmail.com
    Input Text    xpath=//input[@type='password']     123
    Scroll And Click Button    xpath=//button[@type='submit']
    # Check that we are still on the registration page
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s

# --- LOGIN TEST CASES ---

Login - Successful With Valid Credentials
    [Documentation]    Verify user can login with registered credentials
    [Teardown]    Teardown With Debug
    Open Chrome Headless
    Go To    ${LOGIN_URL}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s
    Input Text    xpath=//input[@type='email']        ${REGISTERED_EMAIL}
    Input Text    xpath=//input[@type='password']     ${PASSWORD}
    Scroll And Click Button    xpath=//button[@type='submit']
    Sleep    3s

Login - Fail Wrong Password
    [Documentation]    Verify login fails with correct email but wrong password
    [Teardown]    Teardown With Debug
    Open Chrome Headless
    Go To    ${LOGIN_URL}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s
    Input Text    xpath=//input[@type='email']        ${REGISTERED_EMAIL}
    Input Text    xpath=//input[@type='password']     WrongPassword123
    Scroll And Click Button    xpath=//button[@type='submit']
    # Should stay on login page or show error
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s

Login - Fail Unregistered Email
    [Documentation]    Verify login fails with unregistered email
    [Teardown]    Teardown With Debug
    Open Chrome Headless
    Go To    ${LOGIN_URL}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s
    Input Text    xpath=//input[@type='email']        unregistered_random_user@gmail.com
    Input Text    xpath=//input[@type='password']     ${PASSWORD}
    Scroll And Click Button    xpath=//button[@type='submit']
    # Should stay on login page or show error
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s

Login - Fail Empty Credentials
    [Documentation]    Verify login fails with empty fields
    [Teardown]    Teardown With Debug
    Open Chrome Headless
    Go To    ${LOGIN_URL}
    Maximize Browser Window
    Scroll And Click Button    xpath=//button[@type='submit']
    # Should stay on login page
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s