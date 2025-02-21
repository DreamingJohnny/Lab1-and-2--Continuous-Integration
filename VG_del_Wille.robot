*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource    keywords.robot
Variables    variables.py
Documentation    Willes VG part.

#Test setup that starts up the page in a browser and registers a user. (by Wille)
Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${valid_username}    ${reg_username_text_box}    ${valid_password}    ${reg_password_text_box}    ${reg_button}    ${reg_submit_button}
#Test teardown that closes the browser, made as a suite incase we want to add more functions to it. (by Wille)
Test Teardown    Teardown Suite 
*** Test Cases ***
#Test for booking an buying a regular adult ticket. (by Wille)
Booking 1 regular adult ticket
    [Tags]    Wille Virtanen
    Given The User Is Logged In To Their Account    ${login_button}    ${valid_username}    ${valid_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    When User Books A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Sleep    5
    Then User Booking Goes Through    ${add_to_cart_message_successful}
    
    #Test for booking and buying all diffrent typs of tickets and in diffrent descending quantitys to see that all combinations work. (Wille) They Buys One Of Each Ticket And Safari Combination 
Booking and buying all diffrent typs of tickets and in diffrent descending quantitys
    [Tags]    Wille Virtanen
    Given The User Is Logged In To Their Account    ${login_button}    ${valid_username}    ${valid_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    When User Buys Every Combination Of Ticket And Safari    ${vip_ticket}    ${regular_ticket}    ${senior_ticket_type}    ${adult_ticket_type}    ${child_ticket_type}    
    ...    ${5}    ${4}    ${3}    ${2}    ${1}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    
    ...    ${add_to_cart_message_successful}    ${cart_nav_button}    ${pro_to_checkout_button}
    Then The Price In The Popup Is Correct    ${all_combinations_cost}
   
    #Test for booking and buying Safari. (by Wille)
Booking Safari
    [Tags]    Wille Virtanen
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    5
    Buy A Ticket    ${vip_ticket}    ${senior_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Sleep    5
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
    Handle Alert    action=DISMISS
    Sleep    5
    #Test for booking and buying all dirrfent types of Safari. (by Wille)
Booking and buying all diffrent typs of safaris
    [Tags]    Wille Virtanen
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    5
    Buy A Ticket    ${vip_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Sleep    5
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_herbivor_tour}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble_thrill}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Click Element   ${cart_nav_button}
    #Sleep    5
    ${actual_text}    Get Text    ${vip_ticket_in_cart_spot}
    Should Contain    ${actual_text}    ${vip_ticket_in_cart}
    Should Contain    ${actual_text}    ${trex_rumble_in_cart} 
    Should Contain    ${actual_text}    ${herbivor_in_cart} 
    Should Contain    ${actual_text}    ${herbivorplus_in_cart}
    Should Contain    ${actual_text}    ${trex_rumbleplus_in_cart}  
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
    Handle Alert    action=DISMISS
    Sleep    5
