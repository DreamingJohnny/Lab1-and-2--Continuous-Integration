*** Settings ***
Library    SeleniumLibrary
Resource    keywords.robot

Variables    variables.py
Variables    paleontolog_specific_variables.py

#TODO kolla test setup så jag inte behöver logga in varje gång?


Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${pal_username}    ${reg_username_text_box}    ${pal_password}    ${reg_password_text_box}    ${reg_button}    ${reg_submit_button}
#Test Teardown    Teardown Suite
*** Test Cases ***

Valid browser login
    Click Specific Button    ${login_button}
	Input Credentials    ${pal_username}    ${login_username_text_box}    ${pal_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}
	Sleep    3

Buy one adult ticket

    #While logged in
    Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}
    Check Shopping Cart Total    ${pal_expected_cost_ticket}    ${cart_tab_xpath}    ${cart_total_xpath}

Book Safari
    Book safari    ${safari_button}    ${safari_date_field}    ${pal_safari_date}    ${safari_type_field}    ${safari_type_herbivor_tour}    ${safari_submit_button}
	Book safari    ${safari_button}    ${safari_date_field}    ${pal_safari_date}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}
    Check Shopping Cart Total    ${pal_expected_cost_total}    ${cart_tab_xpath}    ${cart_total_xpath}

# Register user ??

# Kristin
# Given Keyword tex logged_in_as_user
# When Keyword click button 
 # Then ??


 