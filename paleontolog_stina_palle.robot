*** Settings ***
Library    SeleniumLibrary
Resource    keywords.robot

Variables    variables.py
Variables    paleontolog_specific_variables.py


#Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${pal_username}    ${reg_username_text_box}    ${pal_password}    ${reg_password_text_box}    ${reg_button}    ${reg_submit_button}
#Test Teardown    Teardown Suite


*** Test Cases ***


Register user pal
    [Tags]    Kristin
    Open Browser    ${url_demo}    ${browser}    ${title_demo}
    Click Specific Button    ${reg_button}
    Given Page is opened to registration section
    When User pal enters registration credentials
    And User presses register button
    Then User pal is registered    
    
Log in user pal
#    Open Browser    ${url_demo}    ${browser}    ${title_demo}
    Click Specific Button    ${login_button}
    Given User pal is registered
    And Page is opened to login page
    When User pal enters login credentials
    And User presses login button
    Then User pal is logged in

Buy entrance ticket
    Given User pal is logged in
    And    Page is open to buy tickets
# and user is logged in 
# and pal buys one adult ticket 
# then ticket is added to cart

A test
    Open Browser To Page    ${url_demo}    ${browser}    ${title_demo}
    Click Specific Button    ${login_button}
    Wait until page contains element    ${login_section}    ${standard_timeout}



Next test

    Given The User Is Logged In To Their Account    ${login_button}    ${pal_username}    ${pal_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    When The User Buys Ticket    ${buy_ticket_button}    ${regular_ticket}    ${adult_ticket_type }
    ...        ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${add_to_cart_button}
	...    ${add_to_cart_message_successful}
    Then The The Total Price Is Correct    ${cart_tab_xpath}    ${kim_expected_ticket_cost_total}    ${cart_total_xpath}


Buy one adult ticket

    #While logged in
    Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    ${add_to_cart_button}
    Check Shopping Cart Total    ${pal_expected_cost_ticket}    ${cart_tab_xpath}    ${cart_total_xpath}

Book Safari
    Book safari    ${safari_button}    ${safari_date_field}    ${pal_safari_date}    ${safari_type_field}    ${safari_type_herbivor_tour}    ${safari_submit_button}
	Book safari    ${safari_button}    ${safari_date_field}    ${pal_safari_date}    ${safari_type_field}    ${safari_type_t_rex_rumble}    ${safari_submit_button}
    Check Shopping Cart Total    ${pal_expected_cost_total}    ${cart_tab_xpath}    ${cart_total_xpath}




*** Keywords ***


Page is opened to registration section
    Page Should Contain Element    ${reg_section}

User presses Register button
    Click Specific Button    ${reg_submit_button}
    
User should be registred
    Registration message should be visible

Page is opened to login page
    Page Should Contain Element    ${login_section}
    
User pal enters login credentials
    Input Credentials    ${pal_username}    ${login_username_text_box}    ${pal_password}    ${login_password_text_box}

User pal enters registration credentials
    Input Credentials    ${pal_username}    ${reg_username_text_box}    ${pal_password}    ${reg_password_text_box} 

User pal is registered
    ${userRegistered} =    Execute JavaScript    
    ...    let users = getUsers();
    ...    let user = users.find(item => item.username === 'StinaPalle');
    ...    return user.username === 'StinaPalle';
    Should Be True    ${userRegistered}

User presses login button
    Click Specific Button    ${login_submit_button}   

User pal is logged in
    Login message Should Be Visible

    ${UserLoggedIn} =    Execute JavaScript    
    ...    let user = currentUser;
    ...    return user.username;
    Should Be Equal    ${UserLoggedIn}    StinaPalle

    
Login message Should Be Visible
     Message should be visible    ${error_message_element_demo}    ${verifying_message}    ${standard_timeout}

Registration message should be visible
    Message should be visible    ${reg_message_element}    ${reg_success_message}    ${standard_timeout}
 
Message should be visible
    [Arguments]    ${message_element}    ${message}    ${timeout}
    Wait Until Element Is Visible    ${message_element}    ${timeout}
    Element Text Should Be    ${message_element}    ${message}