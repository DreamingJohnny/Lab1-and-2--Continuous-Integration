*** Settings ***
Library    SeleniumLibrary
Resource    keywords.robot
Variables    variables.py

Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${valid_username}    ${reg_username_text_box}    ${valid_password}    ${reg_password_text_box}    ${reg_button}    
Test Teardown    Teardown Suite 
*** Test Cases ***
Invalid browser login
    Click Specific Button    ${login_button}
    Input Credentials    ${invalid_username}    ${login_username_text_box}    ${invalid_password}    ${login_password_text_box}
    Click Element   xpath=/html/body/main/article[3]/section/form/button
    Message Should Be Visible    ${error_message_element_demo}    ${error_message_demo}    ${standard_timeout}    ${verifying_messege}

Valid browser login
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   xpath=/html/body/main/article[3]/section/form/button
    Sleep    3

Valid browser logout
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   xpath=/html/body/main/article[3]/section/form/button
    Sleep    3
    Logout    ${logout_button}