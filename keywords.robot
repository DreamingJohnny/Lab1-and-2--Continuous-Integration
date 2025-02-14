*** Settings ***
Library    SeleniumLibrary

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
    Sleep    5s
    Wait Until Element Is Visible    ${error_message_element}    ${timeout}
    Element Text Should Be    ${error_message_element}    ${error_message_text}
Registration
    [Arguments]    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}
    Click Specific Button    ${regin_button}
    Input Credentials    ${username}    ${username_text_box}    ${password}    ${password_text_box}
    Click Element    xpath=/html/body/main/article[2]/section/form/button
Logout
    [Arguments]    ${button}
    Click Specific Button    ${button}
    Sleep    3
    Handle Alert    action=DISMISS
    Sleep    3    
Setup Suite
    [Arguments]    ${url}    ${browser}    ${title}    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}
    Open Browser To Page    ${url}    ${browser}    ${title} 
    Registration    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}

Teardown Suite    
    Close Browser