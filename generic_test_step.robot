*** Settings ***
Library    SeleniumLibrary

*** Variables ***

${url_demo}    file:///C:/Users/wille/Documents/github%20repos/Lab1-Continuous-Integration/Homepage/jurap.html
${browser}    chrome

*** Test Cases ***
Valid Login 
    Open Browser To Login Page    ${url_demo}    ${browser}
*** Keywords ***
Open Browser To Login Page
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}