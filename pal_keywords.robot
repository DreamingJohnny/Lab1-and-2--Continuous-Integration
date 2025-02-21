*** Settings ***
Library    SeleniumLibrary
Library    Collections


Resource    keywords.robot

Variables    variables.py
Variables    pal_specific_variables.py

*** Keywords ***

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

User pal enters login credentials
    Input Credentials    ${pal_username}    ${login_username_text_box}    ${pal_password}    ${login_password_text_box}

User pal is logged in
    ${UserLoggedIn} =    Execute JavaScript    return currentUser.username;
    Should Be Equal    ${UserLoggedIn}    StinaPalle

### Buying tickets ###

Pal buys one adult regular ticket 
    Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}    ${ticket_cat_field}    ${pal_number_of_tickets}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}

### Pressed buttons ###

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



### Safari bookings ###

Pal books Herbivore safari without feeding
    Book safari    ${safari_type_herbivor_tour}

Pal books T-rex tour
    Book safari    ${safari_type_t_rex_rumble}

### Cart Related ###

Cart is empty
    ${cart} =    Execute JavaScript    return getCart();
    Should Be Empty    ${cart}

Pal ticket is added to cart
    ${listOfCartItemDescriptioins} =    GetCartItemDescriptions
    Should Contain X Times    ${listOfCartItemDescriptioins}       1 Regular Adult Ticket(s)    1

Pal safaris are added to cart
    ${cartItemDescriptioins} =    GetCartItemDescriptions
    Should Contain X Times    ${cartItemDescriptioins}       Herbivore Tour on 2025-03-19    1
    Should Contain X Times    ${cartItemDescriptioins}       T-Rex Rumble on 2025-03-19    1

Dates for safaris are the same
    ${cart} =    Execute JavaScript    return getCart();
    ${datesInCartList} =  Create List   
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
    Append to list   ${datesInCartList}    ${temp}     
    # Om tid fanns i mitt nästa liv skulle jag vilja att 'None' inte lades till i listan och att alla datum sedan jämfördes med varandra, men får det inte att funka
    END
    Should Be Equal    ${datesInCartList}[1]    ${datesInCartList}[2]    # Lösning för detta specifika fall
    
Checkout summary alert shold show with correct Pal info
    ${alert_text} =     Handle Alert    timeout=4 s
    Log    ${alert_text}
    Should Be Equal    ${alert_text}    Checkout Summary: 1 Regular Adult Ticket(s) - $50 Herbivore Tour on 2025-03-19 - $120 T-Rex Rumble on 2025-03-19 - $150 Total: $320

       
    


    

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

GetCartItemDescriptions    # I nästa liv och med mer tid, hade jag velat göra ett generellt "Hämta en lista med de här properties  i carten"-Keyword
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



### Not used ###

User should be registred
    Registration message should be visible

Login message Should Be Visible
     Message should be visible    ${error_message_element_demo}    ${verifying_message}    ${standard_timeout}

Registration message should be visible
    Message should be visible    ${reg_message_element}    ${reg_success_message}    ${standard_timeout}
 
Message should be visible
    [Arguments]    ${message_element}    ${message}    ${timeout}
    Wait Until Element Is Visible    ${message_element}    ${timeout}
    Element Text Should Be    ${message_element}    ${message}