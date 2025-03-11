*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String


Resource    ${keyword_path}login_and_registration_keywords.robot
Resource    ${keyword_path}cart_keywords.robot
Resource    ${keyword_path}message_and_alert_keywords.robot
Resource    ${keyword_path}ticket_and_safari_keywords.robot
Resource    ${keyword_path}button_and_navigation_keywords.robot
Resource    ${keyword_path}from_original_keywords.robot

*** Variables ***
${html_path}    file:///${EXECDIR}/webpage/jurap.html
${VARIABLES_PATH}    ${EXECDIR}/util/variables.py
${keyword_path}    ${EXECDIR}/resources/keyword_files/
*** Keywords ***

#Setup and Teardown

Setup Suite Open Page
    [Documentation]    This setup opens browser to JurasStina-Kalle park home page.
    Open Browser     ${html_path}    ${browser}    ${browser_options}    

Setup Suite Open Page And Register User
    [Documentation]    This setup opens browser to JurasStina-Kalle park home page and registers user.
    [Arguments]    ${username}    ${password}   
    Open Browser     ${html_path}    ${browser}    ${browser_options}    
    User Is Registered    ${username}    ${password}   

Setup Suite Open Page Register And Login User
    [Documentation]    This setup opens browser to JurasStina-Kalle park home page, registers, and logs in user.
    [Arguments]    ${username}    ${password}   
    Open Browser     ${html_path}    ${browser}    ${browser_options}    
    User Is Registered    ${username}    ${password} 
    Log In User    ${username}    ${password} 

Teardown Suite    
    Close Browser

###########

Increase value
    [Arguments]    ${input_id}    ${direction}
    Press Keys  ${input_id}  ${direction} 

The User Proceeds To The Cart    
	Click Element    ${cart_nav_button}

Total Cart Price Should Be Correct
    [Arguments]    ${expected_ticket_cost_total}
	Check Shopping Cart Total    ${expected_ticket_cost_total}    ${cart_tab_xpath}    ${cart_total_xpath}

The User Purchases The Tickets
	Click Element    ${cart_tab_xpath}
	Click Element    ${proceed_to_checkout_button}

The User Purchases The Safaris
	Click Element    ${cart_tab_xpath}
	Click Element    ${proceed_to_checkout_button}

The Price In The Popup Is Correct
    [Arguments]    ${expected_cost_total}
	User Should Recieve Alert With Expected Text    ${expected_cost_total}

User Booking Goes Through
    [Arguments]    ${add_to_cart_message_successful}
	User Should Recieve Alert With Expected Text    ${add_to_cart_message_successful}