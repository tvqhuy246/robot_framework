*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}      https://web.evbtranding.site/register
${BROWSER}  chrome

*** Test Cases ***
Check Registration Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=//input    10s
    Close Browser

Successful Registration
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    Input Text    xpath=//input[@type="email"]        test123@gmail.com
    Input Text    xpath=//input[@type="password"]     Test@123456
    Click Button  xpath=//button[@type="submit"]

    Sleep    3s
    Close Browser
