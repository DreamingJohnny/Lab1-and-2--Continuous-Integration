*** Settings ***
Library    SeleniumLibrary
Library    .venv/Lib/site-packages/robot/libraries/OperatingSystem.py
Resource    keywords.robot

Variables    variables.py
Variables    kim_specific_variables.py

Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${kim_username}    ${reg_username_text_box}    ${kim_password}    ${reg_password_text_box}    ${reg_button}    ${reg_submit_button}
Test Teardown    Teardown Suite
*** Test Cases ***
# (by Johan Ahlsten)
Valid browser login
    Click Specific Button    ${login_button}
	Input Credentials    ${kim_username}    ${login_username_text_box}    ${kim_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}
	Sleep    3

# (by Johan Ahlsten)
User sees the correct price on tickets in cart
    Given The User Is Logged In To Their Account    ${login_button}    ${kim_username}    ${kim_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    When The User Buys Tickets For Their Family    ${buy_ticket_button}    ${regular_ticket}    ${vip_ticket}
	...    ${adult_ticket_type}    ${child_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${add_to_cart_button}
	...    ${add_to_cart_message_successful}
    Then The The Total Price Is Correct    ${cart_tab_xpath}    ${kim_expected_ticket_cost_total}    ${cart_total_xpath}

# (by Johan Ahlsten)
User purchase tickets for their family	#TODO Look into how to move this to a separate function, so that I won't need to repeat it.
    Given The User Is Logged In To Their Account    ${login_button}    ${kim_username}    ${kim_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    When The User Buys Tickets For Their Family    ${buy_ticket_button}    ${regular_ticket}    ${vip_ticket}
	...    ${adult_ticket_type}    ${child_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${add_to_cart_button}
	...    ${add_to_cart_message_successful}
	And The User Purchases The Tickets    ${cart_tab_xpath}    ${proceed_to_checkout_button}
	Then The Price In The Popup Is Correct    ${kim_expected_ticket_cost_total}

# (by Johan Ahlsten)
User books weekend safaris for their family
    Given The User Is Logged In To Their Account    ${login_button}    ${kim_username}    ${kim_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
	And The User Buys Tickets For Their Family    ${buy_ticket_button}    ${regular_ticket}    ${vip_ticket}
	...    ${adult_ticket_type}    ${child_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${add_to_cart_button}
	...    ${add_to_cart_message_successful}
    When The User Books Weekend Safaris For Their Family    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}
	...    ${safari_type_t_rex_rumble_thrill}    ${add_to_cart_message_successful}
    Then The Date Of The Safari Bookings Are Correct    ${cart_list_xpath}    ${cart_tab_xpath}    ${safari_type_herbivor_tour_feeding}
	...    ${safari_type_t_rex_rumble_thrill}    ${kim_expected_safari_date}


# So, we want to see so that the prices are correct as well, yeah? Both in the cart and post checkout.
# I just built a function, so I can use that for a lot of this. So, I want to set one up that goes through and checks each part of the shopping.
# So, do one that is, the price of the items is correct? Yeah,
# So, to begin with, look at total price? Later on, will want to look at other things here as well yeah? Will want to break out dates correct?
User sees correct prices on the orders in their cart
    Given The User Is Logged In To Their Account    ${login_button}    ${kim_username}    ${kim_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
	And The User Buys Tickets For Their Family    ${buy_ticket_button}    ${regular_ticket}    ${vip_ticket}
	...    ${adult_ticket_type}    ${child_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${add_to_cart_button}
	...    ${add_to_cart_message_successful}
    When The User Books Weekend Safaris For Their Family    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}
	...    ${safari_type_t_rex_rumble_thrill}    ${add_to_cart_message_successful}
    Then The Cart Shows The Correct Prices On The Items    ${cart_list_xpath}    ${cart_tab_xpath}    ${ITEM_PRICES}

# (by Johan Ahlsten)
User purchases weekend safaris for their family
    Given The User Is Logged In To Their Account    ${login_button}    ${kim_username}    ${kim_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
	And The User Buys Tickets For Their Family    ${buy_ticket_button}    ${regular_ticket}    ${vip_ticket}
	...    ${adult_ticket_type}    ${child_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${add_to_cart_button}
	...    ${add_to_cart_message_successful}
    When The User Books Weekend Safaris For Their Family    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}
	...    ${safari_type_t_rex_rumble_thrill}    ${add_to_cart_message_successful}
    And The User Purchases The Safaris    ${cart_tab_xpath}    ${proceed_to_checkout_button}
	Then The Price In The Popup Is Correct    ${kim_expected_vacation_cost_total}