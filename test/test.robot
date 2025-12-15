*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}      https://web.evbtranding.site/register
${BROWSER}  chrome
${OPTIONS}  --headless --no-sandbox --disable-dev-shm-usage --disable-gpu

*** Test Cases ***
Check Registration Page
    Open Browser    ${URL}    ${BROWSER}    options=${OPTIONS}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=//input[@type='email']    10s
    Close Browser

Successful Registration
    Open Browser    ${URL}    ${BROWSER}    options=${OPTIONS}
    Maximize Browser Window

    Input Text    xpath=//input[@type='email']        test123@gmail.com
    Input Text    xpath=//input[@type='password']     Test@123456
    Click Button  xpath=//button[@type='submit']

    Wait Until Page Contains    Registration Successful    10s
    Close Browser
