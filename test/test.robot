*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}      https://web.evbtranding.site/register
${BROWSER}  chrome

*** Keywords ***
Open Chrome Headless
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Create WebDriver    ${BROWSER}    chrome_options=${options}

*** Test Cases ***
Check Registration Page
    Open Chrome Headless
    Go To    ${URL}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s
    Close Browser

Successful Registration
    Open Chrome Headless
    Go To    ${URL}
    Maximize Browser Window

    Input Text    xpath=//input[@type='email']        test123@gmail.com
    Input Text    xpath=//input[@type='password']     Test@123456
    Click Button  xpath=//button[@type='submit']

    Wait Until Page Contains    Registration Successful    10s
    Close Browser
