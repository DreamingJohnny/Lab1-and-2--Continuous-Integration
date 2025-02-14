*** Settings ***
Library    SeleniumLibrary
Variables    variables.py
*** Keywords ***
Open Browser To Page
    [Arguments]    ${url}    ${browser}    ${title}
    Open Browser    ${url}    ${browser}
    Title Should Be    ${title}
Click Specific Button
    [Arguments]    ${button}
    Click Element    ${button}
Input Credentials
    [Arguments]    ${username}    ${username_space}    ${password}    ${password_space}
    Input Text    ${username_space}    ${username}
    Input Text    ${password_space}    ${password}
Message Should Be Visible
    [Arguments]    ${error_message_element}    ${error_message_text}    ${timeout}    ${good_mess}
    Wait Until Element Is Visible    ${error_message_element}    ${timeout}
    Element Text Should Be    ${error_message_element}    ${good_mess}
    Sleep    10s
    Wait Until Element Is Visible    ${error_message_element}    ${timeout}
    Element Text Should Be    ${error_message_element}    ${error_message_text}
Registration
    Click Specific Button    ${reg_button}
    Input Credentials    ${valid_username}    ${reg_username_text_box}    ${valid_password}    ${reg_password_text_box}
    Click Element    xpath=/html/body/main/article[2]/section/form/button
    
Setup Suite
    Open Browser To Page    ${url_demo}    ${browser}    ${title_demo} 
    Registration

Teardown Suite
    Click Specific Button    ${logout_button}
    Sleep    3
    Handle Alert    action=DISMISS
    Sleep    3
    Close Browser