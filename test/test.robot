*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${URL}      https://web.evbtranding.site/register
${BROWSER}  Chrome

*** Keywords ***
Open Chrome Headless
    ${options}=    Evaluate    selenium.webdriver.ChromeOptions()    modules=selenium.webdriver  # Cú pháp Selenium 4
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Open Browser    ${URL}    ${BROWSER}    options=${options}  # Dùng Open Browser cho compatibility

*** Test Cases ***
Check Registration Page
    Open Chrome Headless
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s
    Close Browser

Successful Registration
    Open Chrome Headless
    Maximize Browser Window
    Input Text    xpath=//input[@type='email']        test123@gmail.com
    Input Text    xpath=//input[@type='password']     Test@123456
    Click Button  xpath=//button[@type='submit']
    Wait Until Page Contains    Registration Successful    10s
    Close Browser