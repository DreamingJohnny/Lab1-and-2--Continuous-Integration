*** Settings ***
Library    SeleniumLibrary
Resource    keywords.robot
Variables    variables.py


*** Test Cases ***
Invalid browser login
    Open Browser To Page    ${url_demo}    ${browser}    ${title_demo}
    Click Login    ${login_button}
    Input Credentials    ${invalid_username}    ${login_username_text_box}    ${invalid_password}    ${login_password_text_box}
    Click Element   xpath=/html/body/main/article[3]/section/form/button
    Message Should Be Visible    ${error_message_element_demo}    ${error_message_demo}    ${standard_timeout}    ${verifying_messege}

Valid browser login
    Open Browser To Page    ${url_demo}    ${browser}    ${title_demo}
    Click Login    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   xpath=/html/body/main/article[3]/section/form/button
    