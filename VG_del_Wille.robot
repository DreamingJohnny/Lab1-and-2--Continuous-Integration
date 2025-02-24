*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource    keywords.robot
Variables    variables.py
Documentation    Willes VG part.

#Test setup that starts up the page in a browser and registers a user. 
Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${valid_username}    ${reg_username_text_box}    ${valid_password}    ${reg_password_text_box}    ${reg_button}    ${reg_submit_button}
#Test teardown that closes the browser, made as a suite incase we want to add more functions to it. 
Test Teardown    Teardown Suite 
*** Test Cases ***
#Test for booking an buying a regular adult ticket to use as a baseline in the second test. 
Booking 1 regular adult ticket
    [Tags]    [Wille Virtanen]
    Given The User Is Logged In To Their Account    ${login_button}    ${valid_username}    ${valid_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    When User Books A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Sleep    5
    Then User Booking Goes Through    ${add_to_cart_message_successful}
    
    #Test for booking and buying all diffrent typs of tickets and in diffrent descending quantitys to see that all combinations work and veryfie by checking price. 
Booking and buying all diffrent typs of tickets and in diffrent descending quantitys
    [Tags]    [Wille Virtanen]
    Given The User Is Logged In To Their Account    ${login_button}    ${valid_username}    ${valid_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    When User Buys Every Combination Of Ticket    ${vip_ticket}    ${regular_ticket}    ${senior_ticket_type}    ${adult_ticket_type}    ${child_ticket_type}    
    ...    ${5}    ${4}    ${3}    ${2}    ${1}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    
    ...    ${add_to_cart_message_successful}    ${cart_nav_button}    ${pro_to_checkout_button}
    Then The Price In The Popup Is Correct    ${all_combinations_cost}
   
    #Test for booking and buying one safari to use as a baseline for the fourth test.
Booking Safari
    [Tags]    [Wille Virtanen]
    Given The User Is Logged In To Their Account    ${login_button}    ${valid_username}    ${valid_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    And User Books A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    And User Booking Goes through    ${add_to_cart_message_successful}
    When User Books A Safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}    ${add_to_cart_message_successful}    ${cart_nav_button}    ${pro_to_checkout_button} 
    Sleep    5
    Then The Price In The Popup Is Correct    ${reg_ticket_trex_rumble_safari}
    #Test for booking and buying all dirrfent types of safari and veryfie by checking price
Booking and buying all diffrent typs of safaris
    [Tags]    [Wille Virtanen]
    Given The User Is Logged In To Their Account    ${login_button}    ${valid_username}    ${valid_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    And User Books A Ticket    ${vip_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    And User Booking Goes through    ${add_to_cart_message_successful}   
    When User Book Every Typ Of Safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    
    ...    ${safari_type_herbivor_tour}    ${safari_type_herbivor_tour_feeding}    ${safari_type_t_rex_rumble_thrill}     ${safari_submit_button}    
    ...    ${add_to_cart_message_successful}    ${cart_nav_button}    ${pro_to_checkout_button}
    Sleep    5
    Then The Price In The Popup Is Correct    ${all_combinations_safari_cost}
       

