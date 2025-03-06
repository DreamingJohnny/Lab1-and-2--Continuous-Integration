*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    login_and_registration_keywords.robot
Resource    cart_keywords.robot
Resource    ticket_and_safari_keywords.robot

Variables    ../util/variables.py
Variables    ../util/kim_specific_variables.py

*** Keywords ***

Increase value
    [Arguments]    ${input_id}    ${direction}
    Press Keys  ${input_id}  ${direction} 

User Booking Goes Through
    [Arguments]    ${add_to_cart_message_successful}
    ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}

User Buys Every Combination Of Ticket
    [Arguments]
    Buy Entrance Tickets    ${senior_ticket_type}    ${vip_ticket}    5 
    Buy Entrance Tickets    ${senior_ticket_type}    ${regular_ticket}    4  
    Buy Entrance Tickets    ${adult_ticket_type}    ${vip_ticket}    3
    Buy Entrance Tickets    ${adult_ticket_type}    ${regular_ticket}    2
    Buy Entrance Tickets    ${child_ticket_type}    ${vip_ticket}    1
    Buy Entrance Tickets    ${child_ticket_type}    ${regular_ticket}    4

 User Books A Safari
    [Tags]    safari
    [Arguments]    ${safari_type}        ${safari_date} 
    Book safari    ${safari_type}    ${safari_date}

User Book Every Typ Of Safari
    [Tags]    safari    refactor-me
    [Arguments]   
    Book safari    ${safari_type_t_rex_rumble}    ${date_for_booking}
    Book safari    ${safari_type_herbivor_tour}    ${date_for_booking}
    Book safari    ${safari_type_t_rex_rumble_thrill}    ${date_for_booking}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
