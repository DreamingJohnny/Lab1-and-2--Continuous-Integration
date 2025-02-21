
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
    Click Specific Button    ${reg_button}
    Sleep    2

Pal Teardown
    Close Browser


### Page is opened ##

Page is opened to login page
    Page Should Contain Element    ${login_section}

Page is opened to registration section
    Page Should Contain Element    ${reg_section}


### Registration ###

User pal enters registration credentials
    Input Credentials    ${pal_username}    ${reg_username_text_box}    ${pal_password}    ${reg_password_text_box}

User pal is registered
    ${userRegistered} =    Execute JavaScript    
    ...    let users = getUsers();
    ...    let user = users.find(item => item.username === 'StinaPalle');
    ...    return user.username === 'StinaPalle';
    Should Be True    ${userRegistered}


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
    ${UserLoggedIn} =    Execute JavaScript    return currentUser.username;
    Should Be Equal    ${UserLoggedIn}    StinaPalle


### Buying tickets ###

Pal buys one adult regular ticket 
    Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${pal_number_of_tickets}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}


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
    ${listOfCartItemDescriptioins} =    Get Cart Item Descriptions
    Should Contain X Times    ${listOfCartItemDescriptioins}       1 Regular Adult Ticket(s)    1

Pal safaris are added to cart
    ${cartItemDescriptioins} =    Get Cart Item Descriptions
    Should Contain X Times    ${cartItemDescriptioins}       Herbivore Tour on 2025-03-19    1
    Should Contain X Times    ${cartItemDescriptioins}       T-Rex Rumble on 2025-03-19    1

All Pals items are in cart
    Pal safaris are added to cart
    Pal ticket is added to cart
    
Dates for safaris are correct
    ${datesInCartList} =  Get cart item dates
    Should Be Equal    ${datesInCartList}[1]    ${datesInCartList}[2]    # Lösning för detta specifika fall
    
Checkout summary alert shows correct Pal info
    ${alert_text} =     Handle Alert    timeout=4 s
    Log    ${alert_text}
    Should Be Equal    ${alert_text}    Checkout Summary: 1 Regular Adult Ticket(s) - $50 Herbivore Tour on 2025-03-19 - $120 T-Rex Rumble on 2025-03-19 - $150 Total: $320


###  Buttons ###

User presses login button
    Click Specific Button    ${login_submit_button}
    Sleep    2

User presses Register button
    Click Specific Button    ${reg_submit_button}
    Sleep    2

User navigates to Buy Ticket page
    Click Specific Button    ${buy_ticket_button}
    Sleep    2

User navigates to cart section
    Click Specific Button    ${cart_nav_button}
    Sleep    2

User presses Proceed To Checkout
    Click Specific Button    ${pro_to_checkout_button}
    Sleep    2

Login button is visible
    Element Should Be Visible    ${login_button}


### Misc ###

Total cart cost is correct
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

Get Cart Item Descriptions    # I nästa liv och med mer tid, hade jag velat göra ett generellt "Hämta en lista med de här properties  i carten"-Keyword
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
    # Om tid fanns i mitt nästa liv skulle jag vilja att 'None' inte lades till i listan och att alla datum sedan jämfördes med varandra, men får det inte att funka nu
    END
    RETURN    ${datesList} 


Book safari
    [Arguments]     ${safari_type}
    Click Specific Button    ${safari_button}
    Input Text    ${safari_date_field}    ${pal_safari_date}
    Sleep    1  
    Select From List By Value    ${safari_type_field}    ${safari_type}
    Sleep    1
    Click Element    ${safari_submit_button}
    Sleep    1
    ${alert_text}    Handle Alert    action=DISMISS
    Should Contain    ${alert_text}    ${add_to_cart_message_successful}


