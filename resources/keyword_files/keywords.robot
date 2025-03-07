*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String


Resource    login_and_registration_keywords.robot
Resource    cart_keywords.robot
Resource    message_and_alert_keywords.robot
Resource    ticket_and_safari_keywords.robot
Resource    button_and_navigation_keywords.robot
Resource    from_original_keywords.robot

*** Variables ***
${VARIABLES_PATH}    ${EXECDIR}/util/variables.py


*** Variables ***
${html_path}    file:///${EXECDIR}/webpage/jurap.html


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
	Click Specific Button    ${cart_nav_button}

Total Cart Price Should Be Correct
    [Arguments]    ${expected_ticket_cost_total}
	Check Shopping Cart Total    ${expected_ticket_cost_total}    ${cart_tab_xpath}    ${cart_total_xpath}

The User Purchases The Tickets
	Click Specific Button    ${cart_tab_xpath}
	Click Specific Button    ${proceed_to_checkout_button}

The User Purchases The Safaris
	Click Specific Button    ${cart_tab_xpath}
	Click Specific Button    ${proceed_to_checkout_button}

The Price In The Popup Is Correct
    [Arguments]    ${expected_cost_total}
	${alert_text}    Handle Alert
	Should Contain    ${alert_text}    ${expected_cost_total}

User Booking Goes Through
    [Arguments]    ${add_to_cart_message_successful}
    ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}