*** Settings ***
Library    SeleniumLibrary
Resource    keywords.robot
Variables    variables.py

Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${valid_username}    ${reg_username_text_box}    ${valid_password}    ${reg_password_text_box}    ${reg_button}    ${reg_submit_button}
Test Teardown    Teardown Suite 
*** Test Cases ***
Invalid browser login
    Click Specific Button    ${login_button}
    Input Credentials    ${invalid_username}    ${login_username_text_box}    ${invalid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Message Should Be Visible    ${error_message_element_demo}    ${error_message_demo}    ${standard_timeout}    ${verifying_messege}

Valid browser login
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}   
    Sleep    3

Valid browser logout
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    3
    Logout    ${logout_button}

Booking 1 regular adult ticket
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    5
    Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticker_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${starting_value}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
    Handle Alert    action=DISMISS
    Sleep    5

Booking 2 regular adult ticket
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    5
    #the third variable is how many additional tickets you want to buy
    Buy More Then One Ticket    ${regular_ticket}    ${adult_ticket_type}    ${1}    ${ticker_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${starting_value}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
    Handle Alert    action=DISMISS
    Sleep    5

Booking Safari
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    5
    Buy A Ticket    ${vip_ticket}    ${senior_ticket_type}    ${ticker_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${starting_value}
    Sleep    5
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
    Handle Alert    action=DISMISS
    Sleep    5

Removing object from cart
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    5
    Buy A Ticket    ${vip_ticket}    ${senior_ticket_type}    ${ticker_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${starting_value}
    Sleep    5
    Book safari    ${safari_button}    ${safari_date_field}    ${date_for_booking}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${second_object_in_cart}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
    Handle Alert    action=DISMISS
    Sleep    5