# Group 2: Wille, Johan, Kristin 
# This file was created by Johan

*** Settings ***

Library    SeleniumLibrary
Library    Collections
Library    XML

Resource    ${keyword_path}keywords.robot

Variables    ${util_path}kim_specific_variables.py
Variables    ${util_path}variables.py
*** Variables ***
${util_path}    ${EXECDIR}/resources/util/
${keyword_path}    ${EXECDIR}/resources/keyword_files/

*** Keywords ***

Kim Enters Registration Credentials
    [Documentation]
    User Enters Registration Credentials    ${kim_username}    ${kim_password}

# TODO: Fix this, there is one to easily use!
Kim Should be Registered
    #TODO: Look at if this method can gen become generic and receive argument instead?
    [Documentation]    This keyword verifies that user with username "kimSvensson" is registered as a user,
    ...    by fetching list of users with javascript and finding pal's username in list.
    ${userRegistered} =    Execute JavaScript    
    ...    let users = getUsers();
    ...    return users.some(u => u.username === 'kimSvensson');
    Should Be True    ${userRegistered}

# We might want to set it up so that methods that validate mentions that in their method name? Using either "is" or "should"
# Look into naming, do we need to include User Kim and User Pal?
Kim Is Registered
    User Navigates To Register Section
    Kim Enters Registration Credentials
    Press Register Submit Button
    Kim Should be Registered

Kim Is Logged In To Their Account
    User Navigates To Login Section
    Kim Enters Login Credentials
    User Presses Login Submit Button
	Kim Should Be Logged In

Kim Enters Login Credentials
    User Enters Login Credentials    ${kim_username}    ${kim_password}

Kim Should Be Logged In
    User Should Be Logged In    ${kim_username}

Kim Buys Tickets For Their Family
    [Documentation]
    [Tags]    tickets

	Buy Entrance Tickets    ${adult_ticket_type}    ${regular_ticket}    1
    Buy Entrance Tickets    ${adult_ticket_type}    ${vip_ticket}    1
    Buy Entrance Tickets    ${child_ticket_type}    ${vip_ticket}    2    

Kim Books Weekend Safaris For Their Family
    [Documentation]
    [Tags]    safari    BookingProcess
    [Arguments]    ${safari_date}    
	Book Safari    ${safari_type_herbivor_tour_feeding}    ${safari_date}
	Book Safari    ${safari_type_t_rex_rumble_thrill}    ${safari_date}

The Date Of Kims Safari Bookings Are Correct
    [Documentation]
    [Tags]    safari    BookingProcess

	Dates for safaris in cart are the same and as expected    ${kim_expected_safari_date}

The Checkout Summary Alert Should Show Correct Kim Info
    [Documentation]
	[Tags]    Popup

    ${alert_text} =     Handle Alert    timeout=${standard_timeout}
    Log    ${alert_text}
    Should Contain    ${alert_text}    ${safari_type_herbivor_tour_feeding}
    Should Contain   ${alert_text}    ${safari_type_t_rex_rumble_thrill}
	Should Contain    ${alert_text}    ${kim_expected_vacation_cost_total}