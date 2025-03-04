*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
#Library    XML

Resource    login_and_registration_keywords.robot
Resource    cart_keywords.robot

Variables    ../util/variables.py

*** Keywords ***


Increase value
    [Arguments]    ${input_id}    ${direction}
    Press Keys  ${input_id}  ${direction} 
Buy A Ticket
    [Arguments]    ${cat}    ${type}    ${type_field}    ${cat_field}    ${input_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Click Specific Button    ${buy_ticket_button}
    Sleep    2
    Select From List By Value    ${type_field}    ${type} 
    Select From List By Value    ${cat_field}    ${cat}
    Sleep    2
    Click Button    ${add_to_cart_button}
     ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}

Buy More Than One Ticket
    [Arguments]    ${cat}    ${type}    ${amount}    ${type_field}    ${cat_field}    ${input_counter}    ${button_one}    ${button_two}    ${add_to_cart_message_successful}
    Click Specific Button    ${button_one}
    Sleep    2
    Select From List By Value    ${type_field}    ${type} 
    Select From List By Value    ${cat_field}    ${cat}
    WHILE    True    limit=${amount}    on_limit=pass    
    Increase value    ${input_counter}    ARROW_UP
    END 
    Sleep    2
    Click Button    ${button_two}
     ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}

Book Safari
    [Arguments]    ${saf_button}    ${saf_date_field}    ${date}    ${saf_type_field}    ${saf_type}    ${saf_sub_button}    ${add_to_cart_message_successful}
    Click Element    ${saf_button}
    Sleep    2
    #When booking remember to always put six number in the year slot and start with two 00 as Max has failed in his programing ;)
    Input Text    ${saf_date_field}    ${date}
    Sleep    2    
    Select From List By Value    ${saf_type_field}    ${saf_type}
    Sleep    2
    Click Element    ${saf_sub_button}
    Sleep    2
     ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}


The User Buys Tickets For Their Family
    [Arguments]        ${buy_ticket_button}    ${regular_ticket}    ${vip_ticket}
	...    ${adult_ticket_type}    ${child_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${add_to_cart_button}
	...    ${add_to_cart_message_successful}
	
	Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    
	...    ${add_to_cart_button}    ${add_to_cart_message_successful}
    
	Buy A Ticket    ${vip_ticket}    ${adult_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    
	...    ${add_to_cart_button}    ${add_to_cart_message_successful}
    
	Buy More Than One Ticket    ${vip_ticket}    ${child_ticket_type}    1
	...    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}
	...    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}



The User Books Weekend Safaris For Their Family
    [Arguments]    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}
	...    ${safari_type_t_rex_rumble_thrill}    ${add_to_cart_message_successful}
	Book Safari    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}
	...    ${add_to_cart_message_successful}
	Book Safari    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_t_rex_rumble_thrill}    ${safari_submit_button}
	...    ${add_to_cart_message_successful}

The Date Of The Safari Bookings Are Correct
    [Arguments]    ${cart_list_xpath}    ${cart_tab_xpath}    ${safari_keyword_1}
	...    ${safari_keyword_2}    ${expected_safari_date}

    Check Cart Items Order Info    ${safari_keyword_1}    ${expected_safari_date}    ${cart_tab_xpath}    ${cart_list_xpath}
	Check Cart Items Order Info    ${safari_keyword_2}    ${expected_safari_date}    ${cart_tab_xpath}    ${cart_list_xpath}

User Books A Ticket
    [Arguments]    ${cat}    ${type}    ${type_field}    ${cat_field}    ${input_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Click Specific Button    ${buy_ticket_button}
    Sleep    5
    Select From List By Value    ${type_field}    ${type} 
    Select From List By Value    ${cat_field}    ${cat}
    Sleep    5
    Click Button    ${add_to_cart_button}

User Booking Goes Through
    [Arguments]    ${add_to_cart_message_successful}
    ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}

User Buys Every Combination Of Ticket
    [Arguments]    ${VIP_ticket}    ${regular_ticket}    ${senior_ticket_type}    ${adult_ticket_type}    ${child_ticket_type}    ${5}    ${4}    ${3}    ${2}    ${1}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}    ${cart_nav_button}    ${pro_to_checkout_button}    
    Buy More Than One Ticket    ${vip_ticket}    ${senior_ticket_type}    ${5}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Buy More Than One Ticket    ${regular_ticket}    ${senior_ticket_type}    ${4}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Buy More Than One Ticket    ${vip_ticket}    ${child_ticket_type}    ${3}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Buy More Than One Ticket    ${regular_ticket}    ${child_ticket_type}    ${2}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Buy More Than One Ticket    ${vip_ticket}    ${adult_ticket_type}    ${1}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
 
 User Books A Safari
    [Arguments]    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}    ${add_to_cart_message_successful}    ${cart_nav_button}    ${pro_to_checkout_button} 
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Sleep    5
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}

User Book Every Typ Of Safari
    [Arguments]    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_type_herbivor_tour}    ${safari_type_herbivor_tour_feeding}    ${safari_type_t_rex_rumble_thrill}     ${safari_submit_button}    ${add_to_cart_message_successful}    ${cart_nav_button}    ${pro_to_checkout_button}
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_herbivor_tour}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble_thrill}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
