*** Settings ***
Library    SeleniumLibrary
Resource    keywords.robot

Variables    variables.py
Variables    kim_specific_variables.py

Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${kim_username}    ${reg_username_text_box}    ${kim_password}    ${reg_password_text_box}    ${reg_button}    ${reg_submit_button}
Test Teardown    Teardown Suite
*** Test Cases ***
# Johan Ahlsten
Valid browser login
    Click Specific Button    ${login_button}
	Input Credentials    ${kim_username}    ${login_username_text_box}    ${kim_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}
	Sleep    3

# Johan Ahlsten
Buy one regular adult ticket one VIP adult ticket and two VIP child tickets
	#TODO Look into how to move this to a separate function, so that I won't need to repeat it.
    Click Specific Button    ${login_button}
	Input Credentials    ${kim_username}    ${login_username_text_box}    ${kim_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}
	Sleep    3

    Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}
    Buy A Ticket    ${vip_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}
    Buy More Than One Ticket    ${vip_ticket}    ${child_ticket_type}    1    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}
	Check Shopping Cart Total    ${kim_expected_ticket_cost_total}    ${cart_tab_xpath}    ${cart_total_xpath}

Book three weekend safaris
    #TODO Look into how to move this to a separate function, so that I won't need to repeat it.
    Click Specific Button    ${login_button}
	Input Credentials    ${kim_username}    ${login_username_text_box}    ${kim_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}
	Sleep    3

    #TODO Much the same here, see how much of this we can break out into keywords or similar
    Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}
    Buy A Ticket    ${vip_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}
    Buy More Than One Ticket    ${vip_ticket}    ${child_ticket_type}    1    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}
	
    Book safari    ${safari_button}    ${safari_date_field}    ${kim_safari_date}    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}
	Book safari    ${safari_button}    ${safari_date_field}    ${kim_safari_date}    ${safari_type_field}    ${safari_type_t_rex_rumble_thrill}    ${safari_submit_button}
    Check Shopping Cart Total    ${kim_expected_vacation_cost_total}    ${cart_tab_xpath}    ${cart_total_xpath}