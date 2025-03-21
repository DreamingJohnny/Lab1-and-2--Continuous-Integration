*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ${keyword_path}login_and_registration_keywords.robot
Resource    ${keyword_path}cart_keywords.robot
Resource    ${keyword_path}ticket_and_safari_keywords.robot

Variables    ${util_path}variables.py
Variables    ${util_path}kim_specific_variables.py
*** Variables ***
${util_path}    ${EXECDIR}/resources/util/
${keyword_path}    ${EXECDIR}/resources/keyword_files/
*** Keywords ***

Increase value
    [Arguments]    ${input_id}    ${direction}
    Press Keys  ${input_id}  ${direction} 

User Booking Goes Through
    [Arguments]    ${add_to_cart_message_successful}
    User Should Recieve Alert With Expected Text    ${add_to_cart_message_successful}

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
    Wait Until Element Is Visible    ${pro_to_checkout_button}
	Click Element    ${pro_to_checkout_button}