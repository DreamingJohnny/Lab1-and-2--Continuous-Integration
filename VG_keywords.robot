# Group 3: Wille, Johan, Kristin 
# This file is created, tested, refactored by Kristin

*** Settings ***

Library    SeleniumLibrary
Library    Collections
Library    XML

Resource    keywords.robot
Resource    pal_keywords.robot
Resource    VG_user_generic_keywords.robot

Variables    VG_specific_variables.py



*** Keywords ***

VG Kristin Setup
    [Documentation]    This setup opens browser to JurasStina-Kalle park home page.
    Open Browser To Page    ${url_demo}    ${browser}    ${title_demo} 

VG Kristin Teardown
    [Documentation]    This teardown closes browser.
    Close Browser


User Should Get Message That Username Already Exists
    Message Should Be Displayed    ${reg_message_element}    ${reg_error_message_already_exists}

User Should Get Message That Only VIP User Can Book VIP Safaris
    Message Should Be Displayed    ${safari_message_element}    ${safari_VIP_error_message}

User Should Get Message That VIP Ticket Is Required
    Message Should Be Displayed   ${safari_message_element}    ${safari_weekend_without_VIP_error_message}

User Presses "Add To Cart" Button
    Press Add To Cart Button

User Books Safari On A Weekend
    Book Safari without verification   ${safari_type_herbivor_tour}    ${VG_safari_date_weekend}

User Books Safari
    Book Safari without verification    ${safari_type_herbivor_tour}    ${VG_safari_date_weekday}

User Buys Ticket
    User Navigates To Buy Ticket Section
    Buy Entrance Tickets Without Verification    ${adult_ticket_type}    ${regular_ticket}    ${1}

User books VIP safari
    [Documentation]    This keyword executes booking of VIP safari, without verification.
    Book Safari without verification    ${safari_type_t_rex_rumble_thrill}    ${VG_safari_date_weekend}

    















##Not used, cannot press regoster, is alerted "fyll i det här fältet" first
User Enters Only Username And No Password
    Input Text    ${reg_username_text_box}    ${pal_username}

User Enters Only Password And No Username
    Input Credentials    ${None}    ${reg_username_text_box}    ${pal_password}    ${reg_password_text_box}


    
    
    


