*** Settings ***
Library    SeleniumLibrary
*** Keywords ***
Open Browser To Page
    [Arguments]    ${url}    ${browser}    ${title}
    Open Browser    ${url}    ${browser}
    Title Should Be    ${title}
Click Login
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
