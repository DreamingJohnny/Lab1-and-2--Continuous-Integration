*** Settings ***
Library    SeleniumLibrary  

Resource    ${RESOURCE_PATH}/keyword_files/keywords.robot
Resource    ${EXECDIR}/resources/keyword_files/from_original_keywords.robot
Resource    ${keyword_path}/keywords.robot

Variables    ${resource_path}/util/variables.py
Variables    ${util_path}/pal_specific_variables.py

Documentation   Grupp 2 Wille, Johan och Kristin. Generic test suite for general test functions as a base library.

#Test setup that starts up the page in a browser and registers a user. (by Wille)
Test Setup    Setup Suite Open Page And Register User    ${valid_username}    ${valid_password}
Test Teardown    Teardown Suite 
*** Variables ***
${util_path}    ${EXECDIR}/resources/util/
${resource_path}    ${EXECDIR}/resources/
${keyword_path}    ${EXECDIR}/resources/keyword_files/



*** Test Cases ***
#Invalid login test to see if the page need correct credentials.
Invalid browser login
    [Tags]    Wille-Virtanen    new-feature
    Click Specific Button    ${login_button}
    Input Credentials    ${invalid_username}    ${login_username_text_box}    ${invalid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}

#Valid login test to see that login works with valid credentials.
    User Should Recieve Expected Message    ${error_message_element_demo}    ${verifying_message}

Valid browser login
    [Tags]    Wille-Virtanen
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}   

#Logout test to see that the logout feature of the page works.
Valid browser logout
    [Tags]    Wille-Virtanen
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Wait Until Element Is Visible    ${logout_button}    ${standard_timeout}
    Logout    ${logout_button}
#Test for booking an buying a regular adult ticket.
Booking 1 regular adult ticket
    [Tags]    Wille-Virtanen    Johan-Ahlsten
    Log In User    ${valid_username}    ${valid_password}
    Buy Entrance Tickets    ${adult_ticket_type}    ${regular_ticket}    1

Booking 2 regular adult ticket
    [Tags]    Wille Virtanen    Johan-Ahlsten
    Log In User    ${valid_username}    ${valid_password}
    Buy Entrance Tickets    ${adult_ticket_type}    ${regular_ticket}    2

#Test for booking and buying Safari.
Booking Safari
    [Tags]    Wille-Virtanen    Johan-Ahlsten
    Log In User    ${valid_username}    ${valid_password}
    Buy Entrance Tickets    ${senior_ticket_type}    ${vip_ticket}    1
    Book Safari    ${safari_type_herbivor_tour}    ${date_for_booking}

#Test for removing items from cart.
Removing object from cart
    [Tags]    Wille-Virtanen    refactor-me
    Log In User    ${valid_username}    ${valid_password}
    Buy Entrance Tickets    ${senior_ticket_type}    ${vip_ticket}    1
    Book Safari    ${safari_type_t_rex_rumble}    ${date_for_booking}
    User Navigates To Cart Section
    Click Element    ${second_object_in_cart}
    Wait Until Element Is Visible    ${pro_to_checkout_button}    ${standard_timeout}
	Click Element    ${pro_to_checkout_button}
    Handle Alert    action=DISMISS

User Can Not Register Username That Already Exists
    [Documentation]    This test verifies that an error message is displayed if user tries to register an already registered username.
    [Tags]    Kristin
    Given User Is Registered    ${valid_username}    ${valid_password}
    When User Registers Username    ${valid_username}    ${valid_password}
    Then User Should Get Message That Username Already Exists    

User That Is Not Logged In Can Not Add Ticket To Cart
    [Documentation]    This test verifies that an error alert is displayed if user that is not logged in tries to buy entrance ticket. 
    [Tags]    Kristin    
    Given No one is logged in
    When User Buys Ticket
    Then User Should Recieve Alert With Expected Text    ${ticket_login_error_message}

User That Is Not Logged In Can Not Book Safari
    [Documentation]    This test verifies that an error alert is displayed if user that is not logged in tries to book a safari. 
    [Tags]    Kristin
    Given No one is logged in
    When User Books Safari
    Then User Should Recieve Alert With Expected Text    ${safari_login_error_message}

User With Regular Ticket Can Not Book VIP Safari
    [Documentation]    This test verifies that an error message is displayed if user tries to book VIP safari without VIP ticket.
    [Tags]    Kristin
    Given User Is Logged In    ${valid_username}    ${valid_password}
    And Regular Entrance Ticket is Added To Cart
    When User books VIP safari
    Then User Should Get Message That Only VIP User Can Book VIP Safaris
    
User With Regular Ticket Can Not Book Safari On Weekend
    [Documentation]    This test verifies that an error message is displayed if user tries to book safari on a weekend without VIP ticket.
    [Tags]    Kristin
    Given User Is Logged In    ${valid_username}    ${valid_password}
    And Regular Entrance Ticket Is Added To Cart
    When User Books Safari On A Weekend
    Then User Should Get Message That VIP Ticket Is Required