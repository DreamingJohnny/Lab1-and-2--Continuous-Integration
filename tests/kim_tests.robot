*** Settings ***
Library    SeleniumLibrary
#Library    .venv/Lib/site-packages/robot/libraries/OperatingSystem.py

Resource    ../resources/keyword_files/keywords.robot
Variables    ../resources/util/variables.py



Variables    ../resources/util/kim_specific_variables.py

Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${kim_username}    ${reg_username_text_box}    ${kim_password}    ${reg_password_text_box}    ${reg_button}    ${reg_submit_button}
Test Teardown    Teardown Suite

*** Test Cases ***
Valid browser login
    [Tags]    Johan-Ahlsten    new-feature
    Click Specific Button    ${login_button}
	Input Credentials    ${kim_username}    ${login_username_text_box}    ${kim_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}
	Sleep    3

User sees the correct price total on tickets in cart
    [Tags]    Johan-Ahlsten    new_feature
    Given The User Is Logged In To Their Account    ${login_button}    ${kim_username}    ${kim_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    When The User Buys Tickets For Their Family    ${buy_ticket_button}    ${regular_ticket}    ${vip_ticket}
	...    ${adult_ticket_type}    ${child_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${add_to_cart_button}
	...    ${add_to_cart_message_successful}
    Then The The Total Price Is Correct    ${cart_tab_xpath}    ${kim_expected_ticket_cost_total}    ${cart_total_xpath}

User purchase tickets for their family
    [Tags]    Johan-Ahlsten new-feature
    Given The User Is Logged In To Their Account    ${login_button}    ${kim_username}    ${kim_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    When The User Buys Tickets For Their Family    ${buy_ticket_button}    ${regular_ticket}    ${vip_ticket}
	...    ${adult_ticket_type}    ${child_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${add_to_cart_button}
	...    ${add_to_cart_message_successful}
	And The User Purchases The Tickets    ${cart_tab_xpath}    ${proceed_to_checkout_button}
	Then The Price In The Popup Is Correct    ${kim_expected_ticket_cost_total}

User books weekend safaris for their family
    [Tags]    Johan-Ahlsten
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

User purchases weekend safaris for their family
    [Tags]    Johan Ahlsten
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