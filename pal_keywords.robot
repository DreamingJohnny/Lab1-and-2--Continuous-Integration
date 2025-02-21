
*** Settings ***

Library    SeleniumLibrary
Library    Collections

Resource    keywords.robot

Variables    variables.py
Variables    pal_specific_variables.py

# This file is created, tested, refactored by Kristin

*** Keywords ***

Pal Setup
    Open Browser To Page    ${url_demo}    ${browser}    ${title_demo} 

Pal Teardown
    Close Browser


### Page is opened ##

Page is opened to login page
    Press login button
    Page Should Contain Element    ${login_section}

Page is opened to registration section
    Press Register button
    Page Should Contain Element    ${reg_section}

Page is opened to safari section
    Press safari button
    Page Should Contain Element    ${safari_section}


### Registration ###

User pal enters registration credentials
    Input Credentials    ${pal_username}    ${reg_username_text_box}    ${pal_password}    ${reg_password_text_box}

User pal is registered
    [Documentation]    This keyword verifies that user pal is registerd as a user.
    ${userRegistered} =    Execute JavaScript    
    ...    let users = getUsers();
    ...    let user = users.find(item => item.username === 'StinaPalle');
    ...    return user.username === 'StinaPalle';
    Should Be True    ${userRegistered}

User pal has registered
    [Documentation]    This keyword executes and verifies user pal registration.
    Press Register button
    User pal enters registration credentials
    Press register submit button
    User pal is registered


### Login ###

Log in user pal
    Click Specific Button    ${login_button}
    Sleep    2
    User pal enters login credentials
    Click Specific Button    ${login_submit_button}
    Sleep    2

No one is logged in
    Login button is visible

User pal enters login credentials
    Input Credentials    ${pal_username}    ${login_username_text_box}    ${pal_password}    ${login_password_text_box}

User pal is logged in
    [Documentation]    This keyword verifies that user pal is logged in.
    ${UserLoggedIn} =    Execute JavaScript    return currentUser.username;
    Should Be Equal    ${UserLoggedIn}    StinaPalle

User pal has logged in
    [Documentation]    This keyword executes and verifies user pal login.
    User pal has registered
    Log in user pal
    User pal is logged in

### Buying tickets ###

Pal buys one adult regular ticket 
    Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${1}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}


### Safari bookings ###

Pal books Herbivore safari without feeding
    Book safari    ${safari_type_herbivor_tour}

Pal books T-rex tour
    Book safari    ${safari_type_t_rex_rumble}


### Cart ###

Cart is empty
    ${cart} =    Execute JavaScript    return getCart();
    Should Be Empty    ${cart}

Pal ticket is added to cart
    [Documentation]    This keyword verifies purchase of one adult regular ticket.
    ${listOfCartItemDescriptioins} =    Get Cart Item Descriptions
    Should Contain X Times    ${listOfCartItemDescriptioins}       1 Regular Adult Ticket(s)    1

Pal ticket was added to cart
    [Documentation]    This keyword executes and verifies purchase of one adult regular ticket.
    Press Ticket button
    Pal buys one adult regular ticket
    Pal ticket is added to cart
    
Pal safaris are added to cart
    [Documentation]    This keyword verifies purchase of safaris of pal's choice.
    ${cartItemDescriptioins} =    Get Cart Item Descriptions
    Should Contain X Times    ${cartItemDescriptioins}       Herbivore Tour on 2025-03-19    1
    Should Contain X Times    ${cartItemDescriptioins}       T-Rex Rumble on 2025-03-19    1

All Pals items was added to cart
    [Documentation]    This keyword executes and verifies purchase of safaris of pal's choice.
    Pal buys one adult regular ticket
    Pal books Herbivore safari without feeding
    Pal books T-rex tour
    Pal safaris are added to cart
    Pal ticket is added to cart
    
Dates for safaris are correct
    [Documentation]    This keyword verifies that the dates for pal's safaris are the same.
    ${datesInCartList} =  Get cart item dates
    Should Be Equal    ${datesInCartList}[1]    ${datesInCartList}[2]
    Should Be Equal    ${datesInCartList}[1]    ${pal_expected_safari_date}

Checkout summary alert shows correct Pal info
    [Documentation]    This keyword verifies that the checkout summary alert 
    ...    contains pal's order info.
    ${alert_text} =     Handle Alert    timeout=4 s
    Log    ${alert_text}
    Should Be Equal    ${alert_text}    Checkout Summary: 1 Regular Adult Ticket(s) - $50 Herbivore Tour on 2025-03-19 - $120 T-Rex Rumble on 2025-03-19 - $150 Total: $320


###  Buttons ###

User presses login button
    Press login button
    Page Should Contain Element    ${login_section}

User presses register button
    Press register submit button
    Page Should Contain Element    ${reg_section}

User navigates to Buy Ticket page
    Press Ticket button
    Page Should Contain Element    ${tickets_section}

User navigates to cart section
    Press Cart button
    Page Should Contain Element    ${cart_section}

User presses Proceed To Checkout
    Click Specific Button    ${pro_to_checkout_button}
    Sleep    2

Login button is visible
    Element Should Be Visible    ${login_button}

Press Register button
    Click Specific Button    ${reg_button}
    Sleep    2

Press register submit button
    Click Specific Button    ${reg_submit_button}
    Sleep    2

Press Ticket button
    Click Specific Button    ${buy_ticket_button}
    Sleep    2

Press Cart button
    Click Specific Button    ${cart_nav_button}
    Sleep    2

Press login button
    Click Specific Button    ${login_submit_button}
    Sleep    2

Press safari button
    Click Specific Button    ${safari_button}
    Sleep    2

### Misc ###

Total cart cost is correct
    [Documentation]    This keyword verifies that cart cost is same as expected
    ...    by looping through cart and adding all prices. 
    [Arguments]    ${expectedCost}
    ${cart} =    Execute JavaScript    return getCart();
    ${totalPriceInCart} =  Set Variable    0    
    ${cartLength} =     Get Length    ${cart}
    FOR     ${i}    IN RANGE     0    ${cartLength}
        ${tempItemPrice} =    Execute Javascript            
        ...    let item = ${cart}[${i}];
        ...    return item.price;
        ${totalPriceInCart}    Evaluate    ${totalPriceInCart} + ${tempItemPrice}
    END
    Should Be Equal As Numbers    ${totalPriceInCart}    ${expectedCost}

Get Cart Item Descriptions    
    [Documentation]    This keyword fetches a list of descriptions of all items in cart.
    ...    With more time, I would have liked a general "Get list by property" keyword 
    ${cart} =    Execute JavaScript    return getCart();
    ${cartLength} =    Get Length    ${cart}
    ${cartItemDescriptions} =    Create List
    FOR     ${i}    IN RANGE     0    ${cartLength}
        ${temp} =    Execute Javascript           
            ...    let item = ${cart}[${i}];
            ...    return item.description;
        Append To List    ${cartItemDescriptions}    ${temp}
    END
    RETURN    ${cartItemDescriptions}

Get cart item dates
    [Documentation]    This keyword fetches a list of dates of all safaris in cart.
    ...    With more time, I would have fixed the "None" entry at index 0
    ...    Tried "if temp = None then do not add to list", but did not get that to work
    ${datesList} =  Create List 
    ${cart} =    Execute JavaScript    return getCart();
    ${cartLength} =     Get Length    ${cart}
    FOR    ${i}    IN RANGE    0    ${cartLength}
        ${temp} =     Execute Javascript
        ...    let item = ${cart}[${i}];
        ...    if (item.hasOwnProperty('date')){
        ...        let returnString =  String(item.date);
        ...        return returnString;
        ...    }
        ...    else {    
        ...        return;   
        ...    }
        Append to list   ${datesList}    ${temp}
    END
    RETURN    ${datesList} 


Book safari
    [Documentation]    This keyword executes and verifies the "book safari" process
    [Arguments]     ${safari_type}
    Press safari button
    Input Text    ${safari_date_field}    ${pal_safari_date}
    Select From List By Value    ${safari_type_field}    ${safari_type}
    Click Element    ${safari_submit_button}
    Sleep    2
    ${alert_text}    Handle Alert    action=DISMISS
    Should Contain    ${alert_text}    ${add_to_cart_message_successful}


