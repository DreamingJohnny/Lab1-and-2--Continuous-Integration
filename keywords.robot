*** Settings ***
Library    SeleniumLibrary
*** Keywords ***
Open Browser To Login Page
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}