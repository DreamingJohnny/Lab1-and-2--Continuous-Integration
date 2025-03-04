*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
#Library    XML

Resource    login_and_registration_keywords.robot
Resource    button_and_navigation_keywords.robot
Resource    from_original_keywords.robot

Variables    ../util/variables.py


*** Keywords ***




Buy Entrance Tickets
    [Documentation]    This keyword executes and verifies adding entrance ticket(s) to cart. 
    [Arguments]    ${selected_type}    ${selected_category}     ${selected_quantity}
    User Navigates To Buy Ticket Section
    Select From List By Value    ${ticket_type_field}    ${selected_type} 
    Select From List By Value    ${ticket_cat_field}    ${selected_category}
    Input Text  ${input_of_ticket_counter}   ${selected_quantity}
    Press Add Ticket To Cart Button
     ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}

Buy Entrance Tickets Without Verification
    [Documentation]    This keyword executes and verifies adding entrance ticket(s) to cart, without verification. 
    ...    Error message/alert should be handled elsewhere.   
    [Arguments]    ${selected_type}    ${selected_category}     ${selected_quantity}
    User Navigates To Buy Ticket Section
    Select From List By Value    ${ticket_type_field}    ${selected_type} 
    Select From List By Value    ${ticket_cat_field}    ${selected_category}
    Input Text  ${input_of_ticket_counter}   ${selected_quantity}
    Press Add Ticket To Cart Button


Book Safari K
    [Documentation]    This keyword executes and verifies the "book safari" process
    [Arguments]     ${safari_type}    ${safari_date}
    Press Safari Button
    Input Text    ${safari_date_field}    ${safari_date}
    Select From List By Value    ${safari_type_field}    ${safari_type}
    Press Add Safari To Cart Button
    ${alert_text}    Handle Alert    action=DISMISS
    Should Contain    ${alert_text}    ${add_to_cart_message_successful}

Book Safari Without Verification
    [Documentation]    This keyword executes safari booking process, without verification. 
    ...    Error message/alert should be handled elsewhere.  
        [Arguments]     ${safari_type}    ${safari_date}
    User Navigates To Safari Section
    Input Text    ${safari_date_field}    ${safari_date}
    Select From List By Value    ${safari_type_field}    ${safari_type}
    Click Specific Button    ${safari_submit_button}

User Books Safari On A Weekend
    Book Safari without verification   ${safari_type_herbivor_tour}    ${safari_date_weekend}

User Books Safari
    Book Safari without verification    ${safari_type_herbivor_tour}    ${safari_date_weekday}

User Buys Ticket
    User Navigates To Buy Ticket Section
    Buy Entrance Tickets Without Verification    ${adult_ticket_type}    ${regular_ticket}    ${1}

User books VIP safari
    [Documentation]    This keyword executes booking of VIP safari, without verification.
    Book Safari without verification    ${safari_type_t_rex_rumble_thrill}    ${safari_date_weekend}

VIP Entrance Ticket is Added To Cart
    [Documentation]    This keyword executes and verifies adding one adult regular ticket to cart.
    Buy Entrance Tickets    ${adult_ticket_type}    ${vip_ticket}    ${1}

Regular Entrance Ticket is Added To Cart
    [Documentation]    This keyword executes and verifies adding one adult VIP ticket to cart.
    Buy Entrance Tickets    ${adult_ticket_type}    ${regular_ticket}    ${1}
