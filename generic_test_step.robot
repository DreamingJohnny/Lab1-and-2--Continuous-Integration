*** Settings ***
Library    SeleniumLibrary
Resource    keywords.robot
Variables    variables.py


*** Test Cases ***
Valid browser and page
    Open Browser To Login Page    ${url_demo}    ${browser}
