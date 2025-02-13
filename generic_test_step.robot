*** Settings ***
Library    SeleniumLibrary
Resource    keywords.robot
Variables    variables.py


*** Test Cases ***
Valid browser and page
    Open Browser To Page    ${url_demo}    ${browser}    ${title_demo}
    Click Login    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   xpath=/html/body/main/article[3]/section/form/button
    