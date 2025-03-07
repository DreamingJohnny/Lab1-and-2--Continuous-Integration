# Group 2: Wille, Johan, Kristin 
# This file was created by Johan

*** Settings ***

Library    SeleniumLibrary
Library    Collections
Library    XML

Resource    keywords.robot

Variables    ../util/kim_specific_variables.py
Variables    ../util/variables.py


*** Keywords ***

Kim Enters Registration Credentials
    [Documentation]
    User Enters Registration Credentials    ${kim_username}    ${kim_password}

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

Given Kim Is Logged In To Their Account
    User Navigates To Login Section
    Kim Enters Login Credentials
    Press Login Submit Button

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
    [Tags]    safari
    [Arguments]    ${safari_date}    
	Book Safari    ${safari_type_herbivor_tour_feeding}    ${safari_date}
	Book Safari    ${safari_type_t_rex_rumble_thrill}    ${safari_date}

The Date Of Kims Safari Bookings Are Correct
    [Documentation]
    [Tags]    safari    refactor-me
    
    Check Cart Items Order Info    ${safari_type_herbivor_tour_feeding}    ${kim_expected_safari_date}
	Check Cart Items Order Info    ${safari_type_t_rex_rumble_thrill}    ${kim_expected_safari_date}