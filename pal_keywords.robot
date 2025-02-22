
# Group 3: Wille, Johan, Kristin 
# This file is created, tested, refactored by Kristin

*** Settings ***

Library    SeleniumLibrary
Library    Collections

Resource    keywords.robot

Variables    variables.py
Variables    pal_specific_variables.py


*** Keywords ***

Pal Setup
    [Documentation]    This setup opens browser to JurasStina-Kalle park home page.
    Open Browser To Page    ${url_demo}    ${browser}    ${title_demo} 

Pal Teardown
    [Documentation]    This teardown closes browser.
    Close Browser


### Page is opened ##

Page Is Opened To Login Page
    [Documentation]    This keyword executes and verifies navigation to login section. 
    User Navigates To Login Section
    Page Should Contain Element    ${login_section}

Page Is Opened To Registration Section
    [Documentation]    This keyword executes and verifies navigation to user registration section.
    Press Register Button
    Page Should Contain Element    ${reg_section}

Page Is Opened To Safari Section
    [Documentation]    This keyword executes and verifies navigation to safari booking section.
    Press Safari Button
    Page Should Contain Element    ${safari_section}


### Registration ###

User Pal Enters Registration Credentials
    [Documentation]    This keyword enters pal's registration credentials into registration fields.
    Input Credentials    ${pal_username}    ${reg_username_text_box}    ${pal_password}    ${reg_password_text_box}

User Pal Is Registered
    [Documentation]    This keyword verifies that user pal is registerd as a user,
    ...    by fetching list of users with javascript and finding pal's username in list.
    ${userRegistered} =    Execute JavaScript    
    ...    let users = getUsers();
    ...    let user = users.find(item => item.username === 'StinaPalle');
    ...    return user.username === 'StinaPalle';
    Should Be True    ${userRegistered}

User Pal Has Registered
    [Documentation]    This keyword executes and verifies user pal registration.
    Press Register Button
    User Pal Enters Registration Credentials
    Press Register Submit Button
    User Pal Is Registered


### Login ###

Log In User Pal
    User Navigates To Login Section
    User Pal Enters Login Credentials
    Press Login Submit Button

No One Is Logged In
    [Documentation]    This keyword verifies that the login button is visible. 
    Login Button Is Visible

User Pal Enters Login Credentials
    [Documentation]    This keyword enters pal's login credentials into login fields.
    Input Credentials    ${pal_username}    ${login_username_text_box}    ${pal_password}    ${login_password_text_box}

User Pal Is Logged In
    [Documentation]    This keyword verifies that user pal is logged in,
    ...    by using javascript to fetch the username of the current logged in user.
    ${UserLoggedIn} =    Execute JavaScript    return currentUser.username;
    Should Be Equal    ${UserLoggedIn}    StinaPalle

User Pal Has Logged In
    [Documentation]    This keyword executes and verifies user pal login.
    User Pal Has Registered
    Log In User Pal
    User Pal Is Logged In

### Buying entrance ticket ###

Pal Buys Entrance Ticket 
    [Documentation]    This keyword executes and verifies adding entrance ticket of pal's choice to cart.
    Buy A Ticket    ${pal_ticket_category}    ${pal_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${1}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}


### Safari bookings ###

Pal Books Safaris
    [Documentation]    This keyword executes and verifies the booking process 
    ...    of pal's selected safari types and date.
    Book Safari    ${safari_type_t_rex_rumble}    ${pal_safari_date}
    Book Safari    ${safari_type_herbivor_tour}    ${pal_safari_date}


### Cart ###

Cart Is Empty
    [Documentation]    This keyword verifies that cart is empty.
    ${cart} =    Execute JavaScript    return getCart();
    Should Be Empty    ${cart}

Pal Entrance Ticket Is Added To Cart
    [Documentation]    This keyword verifies that pal's entrance ticket is in cart.
    ${listOfCartItemDescriptioins} =    Get Cart Item Descriptions
    Should Contain X Times    ${listOfCartItemDescriptioins}       1 Regular Adult Ticket(s)    1

Pal Entrance Ticket Was Added To Cart
    [Documentation]    This keyword executes and verifies adding pal's entrance ticket to cart.
    Press Ticket Button
    Pal Buys Entrance Ticket
    Pal Entrance Ticket Is Added To Cart
    
Pal Safaris Are Added To Cart
    [Documentation]    This keyword verifies that the safaris of pal's choice is in cart.
    ${cartItemDescriptioins} =    Get Cart Item Descriptions
    Should Contain X Times    ${cartItemDescriptioins}       Herbivore Tour on 2025-03-19    1
    Should Contain X Times    ${cartItemDescriptioins}       T-Rex Rumble on 2025-03-19    1

Pals Items Was Added To Cart
    [Documentation]    This keyword executes and verifies adding pal's entrance ticket and 
    ...    the safaris of pal's choice to cart.
    Pal Buys Entrance Ticket
    Pal Books Safaris
    Pal Safaris Are Added To Cart
    Pal Entrance Ticket Is Added To Cart
    
Dates For Safaris Are Correct
    [Documentation]    This keyword verifies that the dates for pal's safaris are the same as expected.
    ${datesInCartList} =  Get Cart Item Dates
    Should Be Equal    ${datesInCartList}[1]    ${datesInCartList}[2]
    Should Be Equal    ${datesInCartList}[1]    ${pal_expected_safari_date}

Checkout Summary Alert Shows Correct Pal Info
    [Documentation]    This keyword verifies that the checkout summary alert 
    ...    contains pal's order info.
    ${alert_text} =     Handle Alert    timeout=4 s
    Log    ${alert_text}
#    Should Be Equal    ${alert_text}    Checkout Summary: 1 Regular Adult Ticket(s) - $50 Herbivore Tour on 2025-03-19 - $120 T-Rex Rumble on 2025-03-19 - $150 Total: $320
    Should Contain X Times    ${alert_text}    ${pal_ticket_description}    ${pal_number_of_tickets}
    Should Contain X Times   ${alert_text}    ${pal_safari1_description}    1
    Should Contain X Times    ${alert_text}    ${pal_safari2_description}    1
    Should Contain X Times    ${alert_text}    ${pal_total_desctiption}    1


###  Buttons ###

User Navigates To Login Section
    Press Login Button
    Page Should Contain Element    ${login_section}

User Navigates To Register Section
    Press Register Button
    Page Should Contain Element    ${reg_section}

User Navigates To Buy Ticket Section
    Press Ticket Button
    Page Should Contain Element    ${tickets_section}

User Navigates To Safari Section
    Press Cart Button
    Page Should Contain Element    ${safari_section}

User Navigates To Cart Section
    Press Cart Button
    Page Should Contain Element    ${cart_section}

User Presses Register Button
    [Documentation]    This keyword executes pressing registration button.
    Press Register Submit Button

User Presses Login Button
    [Documentation]    This keyword executes pressing login button.
    Press Login Submit Button

User Presses Proceed To Checkout
    [Documentation]    This keyword navigates to cart and presses "Proceed to checkout" button.
    User Navigates To Cart Section
    Press Proceed to checkout button

Login Button Is Visible
    Element Should Be Visible    ${login_button}

Press Login Button
    Click Specific Button    ${login_button}
    Sleep    2

Press Login Submit Button
    Click Specific Button    ${login_submit_button}
    Sleep    2

Press Register Button
    Click Specific Button    ${reg_button}
    Sleep    2

Press Register Submit Button
    Click Specific Button    ${reg_submit_button}
    Sleep    2

Press Ticket Button
    Click Specific Button    ${buy_ticket_button}
    Sleep    2

Press Cart Button
    Click Specific Button    ${cart_nav_button}
    Sleep    2

Press Safari Button
    Click Specific Button    ${safari_button}
    Sleep    2

Press Proceed To Checkout Button
    Click Specific Button    ${pro_to_checkout_button}
    Sleep    2

### Misc ###

Total Cart Cost Is Correct
    [Documentation]    This keyword verifies that total cart cost is same as expected, by looping through cart, 
    ...    add all prices up, using javascript to fetch items in cart and their prices.  
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
    [Documentation]    This keyword fetches a list of descriptions of all items in cart, 
    ...    using javascript to fetch items in cart and their respective descriptions.
    ...    (With more time, I would have liked a general "Get list by property" keyword)
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

Get Cart Item Dates
    [Documentation]    This keyword fetches a list of dates of all safaris in cart, 
    ...    using javascript to fetch items in cart and their respective dates.
    ...    (With more time, I would have fixed the "None" entry at index 0)
    ...    (Tried "if temp = None then do not add to list", but did not get that to work)
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
        Append To List   ${datesList}    ${temp}
    END
    RETURN    ${datesList} 


Book Safari
    [Documentation]    This keyword executes and verifies the "book safari" process
    [Arguments]     ${safari_type}    ${safari_date}
    Press Safari Button
    Input Text    ${safari_date_field}    ${safari_date}
    Select From List By Value    ${safari_type_field}    ${safari_type}
    Click Element    ${safari_submit_button}
    Sleep    2
    ${alert_text}    Handle Alert    action=DISMISS
    Should Contain    ${alert_text}    ${add_to_cart_message_successful}


