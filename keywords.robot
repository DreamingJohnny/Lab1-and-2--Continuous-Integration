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
    [Arguments]    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}    ${reg_sub_button}
    Click Specific Button    ${regin_button}
    Input Credentials    ${username}    ${username_text_box}    ${password}    ${password_text_box}
    Click Element    ${reg_sub_button}
Logout
    [Arguments]    ${button}
    Click Specific Button    ${button}
    Sleep    3
    Handle Alert    action=DISMISS
    Sleep    3

Increase value
    [Arguments]    ${input_id}    ${direction}
    Press Keys  ${input_id}  ${direction} 
Buy A Ticket
    [Arguments]    ${cat}    ${type}    ${type_field}    ${cat_field}    ${input_counter}    ${buy_ticket_button}    ${add_to_cart_button}
    Click Specific Button    ${buy_ticket_button}
    Sleep    5
    Select From List By Value    ${type_field}    ${type} 
    Select From List By Value    ${cat_field}    ${cat}
    Sleep    5
    Click Button    ${add_to_cart_button}
    Handle Alert    action=DISMISS

Buy More Than One Ticket
    [Arguments]    ${cat}    ${type}    ${amount}    ${type_field}    ${cat_field}    ${input_counter}    ${button_one}    ${button_two}
    Click Specific Button    ${button_one}
    Sleep    5
    Select From List By Value    ${type_field}    ${type} 
    Select From List By Value    ${cat_field}    ${cat}
    WHILE    True    limit=${amount}    on_limit=pass    
    Increase value    ${input_counter}    ARROW_UP
    END 
    Sleep    5
    Click Button    ${button_two}
    Handle Alert    action=DISMISS
Book safari
    [Arguments]    ${saf_button}    ${saf_date_field}    ${date}    ${saf_type_field}    ${saf_type}    ${saf_sub_button}
    Click Element    ${saf_button}
    Sleep    5
    #When booking remember to always put six numer in the year slot and start with two 00 as Max has failed in his programing ;)
    Input Text    ${saf_date_field}    ${date}
    Sleep    5    
    Select From List By Value    ${saf_type_field}    ${saf_type}
    Sleep    5
    Click Element    ${saf_sub_button}
    Sleep    5
    Handle Alert    action=DISMISS

Check Shopping Cart Total
    [Arguments]    ${expected_total}    ${cart_nav_button}    ${cart_total_xpath}
    Click Specific Button    ${cart_nav_button}
	${actual_text}    Get Text    ${cart_total_xpath}
	Should Contain    ${actual_text}    ${expected_total}


#Setup and Teardown
Setup Suite
    [Arguments]    ${url}    ${browser}    ${title}    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}    ${reg_sub_button}
    Open Browser To Page    ${url}    ${browser}    ${title} 
    Registration    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}    ${reg_sub_button}

Teardown Suite    
    Close Browser