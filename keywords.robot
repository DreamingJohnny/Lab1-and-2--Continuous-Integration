*** Settings ***
Library    SeleniumLibrary
Library    .venv/Lib/site-packages/robot/libraries/Collections.py

*** Keywords ***
Open Browser To Page
    [Arguments]    ${url}    ${browser}    ${title}
    Open Browser    ${url}    ${browser}
    Title Should Be    ${title}
Click Specific Button
    [Arguments]    ${button}
    Click Element    ${button}
Input Credentials
    [Arguments]    ${username}    ${username_space}    ${password}    ${password_space}
    Input Text    ${username_space}    ${username}
    Input Text    ${password_space}    ${password}
Message Should Be Visible
    [Arguments]    ${error_message_element}    ${error_message_text}    ${timeout}    ${good_mess}
    Wait Until Element Is Visible    ${error_message_element}    ${timeout}
    Element Text Should Be    ${error_message_element}    ${good_mess}
    Sleep    5s
    Wait Until Element Is Visible    ${error_message_element}    ${timeout}
    Element Text Should Be    ${error_message_element}    ${error_message_text}
Registration
    [Arguments]    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}    ${reg_sub_button}
    Click Specific Button    ${regin_button}
    Input Credentials    ${username}    ${username_text_box}    ${password}    ${password_text_box}
    Click Element    ${reg_sub_button}
Logout
    [Arguments]    ${button}
    Click Specific Button    ${button}
    Sleep    3
    Handle Alert    action=DISMISS
    Sleep    3

Increase value
    [Arguments]    ${input_id}    ${direction}
    Press Keys  ${input_id}  ${direction} 
Buy A Ticket
    [Arguments]    ${cat}    ${type}    ${type_field}    ${cat_field}    ${input_counter}    ${buy_ticket_button}    ${add_to_cart_button}
    Click Specific Button    ${buy_ticket_button}
    Sleep    5
    Select From List By Value    ${type_field}    ${type} 
    Select From List By Value    ${cat_field}    ${cat}
    Sleep    5
    Click Button    ${add_to_cart_button}
    Handle Alert    action=DISMISS

Buy More Than One Ticket
    [Arguments]    ${cat}    ${type}    ${amount}    ${type_field}    ${cat_field}    ${input_counter}    ${button_one}    ${button_two}
    Click Specific Button    ${button_one}
    Sleep    5
    Select From List By Value    ${type_field}    ${type} 
    Select From List By Value    ${cat_field}    ${cat}
    WHILE    True    limit=${amount}    on_limit=pass    
    Increase value    ${input_counter}    ARROW_UP
    END 
    Sleep    5
    Click Button    ${button_two}
    Handle Alert    action=DISMISS
Book Safari
    [Arguments]    ${saf_button}    ${saf_date_field}    ${date}    ${saf_type_field}    ${saf_type}    ${saf_sub_button}
    Click Element    ${saf_button}
    Sleep    5
    #When booking remember to always put six numer in the year slot and start with two 00 as Max has failed in his programing ;)
    Input Text    ${saf_date_field}    ${date}
    Sleep    5    
    Select From List By Value    ${saf_type_field}    ${saf_type}
    Sleep    5
    Click Element    ${saf_sub_button}
    Sleep    5
    Handle Alert    action=DISMISS

Check Shopping Cart Total
    [Arguments]    ${expected_total}    ${cart_tab}    ${cart_total_xpath}
    Click Specific Button    ${cart_tab}
	${actual_text}    Get Text    ${cart_total_xpath}
	Should Contain    ${actual_text}    ${expected_total}

Check Booking Dates
    [Arguments]    ${expected_date}    ${cart_tab}    ${cart_item_container_xpath}
	Click Specific Button    ${cart_tab}
	#Check if there are items
	#If there are items check if they have dates in them
	#If they have dates, compare those to 

The User Is Logged In To Their Account
    [Arguments]    ${login_tab}    ${username}    ${password}    ${username_field}    ${password_field}    ${submit_login_button}
	Click Specific Button    ${login_tab}
	Input Credentials    ${username}    ${username_field}    ${password}    ${password_field}
	Click Specific Button    ${submit_login_button}
	Sleep    3

	# TODO: Need to add way to check that they logged in correctly here.

The User Buys Tickets For Their Family
    [Arguments]        ${buy_ticket_button}    ${regular_ticket}    ${vip_ticket}
	...    ${adult_ticket_type}    ${child_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${add_to_cart_button}
	
	Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    
	...    ${add_to_cart_button}
    
	Buy A Ticket    ${vip_ticket}    ${adult_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    
	...    ${add_to_cart_button}
    
	# TODO: Look into how to have the number one here be sent through in some way, instead of appearing here.
	Buy More Than One Ticket    ${vip_ticket}    ${child_ticket_type}    1
	...    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}
	...    ${buy_ticket_button}    ${add_to_cart_button}

The User Proceeds To The Cart    
    [Arguments]    ${cart_nav_button}
    # TODO: Look @ this with help, should this keyword be here? If it just wraps another?
    # If yes, why not take in variables of the page straight to this script?
	Click Specific Button    ${cart_nav_button}


The The Total Price Is Correct
    [Arguments]    ${cart_tab_xpath}    ${kim_expected_ticket_cost_total}    ${cart_total_xpath}
	Check Shopping Cart Total    ${kim_expected_ticket_cost_total}    ${cart_tab_xpath}    ${cart_total_xpath}

The User Purchases The Tickets
    [Arguments]    ${cart_tab_xpath}    ${proceed_to_checkout_button}
	Click Specific Button    ${cart_tab_xpath}
	Click Specific Button    ${proceed_to_checkout_button}
	# So, if we don't handle the popup here, but instead does that in the next step? We need to check so that works.

The User Purchases The Safaris
    [Arguments]    ${cart_tab_xpath}    ${proceed_to_checkout_button}
	Click Specific Button    ${cart_tab_xpath}
	Click Specific Button    ${proceed_to_checkout_button}

The Price In The Popup Is Correct
    [Arguments]    ${expected_cost_total}
	${alert_text}    Handle Alert
	Should Contain    ${alert_text}    ${expected_cost_total}

The User Books Weekend Safaris For Their Family
    [Arguments]    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}
	...    ${safari_type_t_rex_rumble_thrill}
	Book Safari    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}
	Book Safari    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_t_rex_rumble_thrill}    ${safari_submit_button}


The Date Of The Safari Bookings Are Correct
    [Arguments]    ${cart_list_xpath}    ${cart_tab_xpath}    ${safari_keyword_1}
	...    ${safari_keyword_2}    ${expected_safari_date}

    Click Specific Button    ${cart_tab_xpath}

    ${elements}    Get WebElements    ${cart_list_xpath}
    
    ${filtered_items}    Create List
    FOR    ${el}    IN    @{elements}
        ${text}    Get Text    ${el}
		# If statement appends element to list if element-text contains either of the two keywords 
        IF    $safari_keyword_1 in $text or $safari_keyword_2 in $text 
            Append To List    ${filtered_items}    ${text}
        END
    END

    Should Not Be Empty    ${filtered_items}    No items found with first-string!

    FOR    ${item}    IN    @{filtered_items}
        Should Contain    ${item}    ${expected_safari_date}
    END

#Setup and Teardown
Setup Suite
    [Arguments]    ${url}    ${browser}    ${title}    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}    ${reg_sub_button}
    Open Browser To Page    ${url}    ${browser}    ${title} 
    Registration    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}    ${reg_sub_button}

Teardown Suite    
    Close Browser