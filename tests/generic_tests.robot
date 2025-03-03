*** Settings ***
Library    SeleniumLibrary

Resource    ../resources/keyword_files/keywords.robot
Variables    ../resources/util/variables.py

Documentation   Grupp 2 Wille, Johan och Kristin. Generic test suite for general test functions as a base library.

#Test setup that starts up the page in a browser and registers a user. (by Wille)
Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${valid_username}    ${reg_username_text_box}    ${valid_password}    ${reg_password_text_box}    ${reg_button}    ${reg_submit_button}
#Test teardown that closes the browser, made as a suite incase we want to add more functions to it. (by Wille)
Test Teardown    Teardown Suite 
*** Test Cases ***
#Invalid login test to see if the page need correct credentials. 
Invalid browser login
    [Tags]    [Wille Virtanen]
    Click Specific Button    ${login_button}
    Input Credentials    ${invalid_username}    ${login_username_text_box}    ${invalid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
#Valid login test to see that login works with valid credentials.
    Message Should Be Visible    ${error_message_element_demo}    ${error_message_demo}    ${standard_timeout}    ${verifying_message}
Valid browser login
    [Tags]    [Wille Virtanen]
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}   
    Sleep    3
#Logout test to see that the logout feature of the page works.
Valid browser logout
    [Tags]    [Wille Virtanen]
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    3
    Logout    ${logout_button}
#Test for booking an buying a regular adult ticket.
Booking 1 regular adult ticket
    [Tags]    [Wille Virtanen] [Refactored by Johan Ahlsten]
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    5
#When booking remember to always put six numer in the year slot and start with two 00 as Max has failed in his programing ;)
    Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
    Handle Alert    action=DISMISS
    Sleep    5
#Test for booking and buying additional tickets.
Booking 2 regular adult ticket
    [Tags]    [Wille Virtanen] [Refactored by Johan Ahlsten]
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    5
    #the third variable is how many additional tickets you want to buy
    Buy More Than One Ticket    ${regular_ticket}    ${adult_ticket_type}    ${1}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
    Handle Alert    action=DISMISS
    Sleep    5
#Test for booking and buying Safari.
Booking Safari
    [Tags]    [Wille Virtanen] [Refactored by Johan Ahlsten]
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    5
    Buy A Ticket    ${vip_ticket}    ${senior_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Sleep    5
    Book Safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
    Handle Alert    action=DISMISS
    Sleep    5
#Test for removing items from cart.
Removing object from cart
    [Tags]    [Wille Virtanen]
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    5
    Buy A Ticket    ${vip_ticket}    ${senior_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Sleep    5
    Book Safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}    ${add_to_cart_message_successful}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${second_object_in_cart}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
    Handle Alert    action=DISMISS
    Sleep    5