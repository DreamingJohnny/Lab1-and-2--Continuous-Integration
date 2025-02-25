# Group 3: Wille, Johan, Kristin 
# This file is created, tested, refactored by Kristin

*** Settings ***

Library    SeleniumLibrary
Library    Collections
Library    XML

Resource    keywords.robot
#Resource    pal_keywords.robot

Variables    VG_Kristin_specific_variables.py

*** Keywords ***

User Is Registered
    [Documentation]    This keyword executes and verifies user registration.
    [Arguments]    ${username}    ${password}
    User Registers Username    ${username}    ${password}
    User should be registered    ${username}

User Is Logged In
    [Documentation]    This keyword executes and verifies user login.
    User Is Registered    ${VG_username}    ${VG_password}
    Log In User    ${VG_username}    ${VG_password}   
    User Should Be Logged In    ${VG_username}



User Enters Registration Credentials
    [Documentation]    This keyword enters username and password into registration fields.
    [Arguments]    ${username}    ${password}
    Input Credentials    ${username}    ${reg_username_text_box}    ${password}    ${reg_password_text_box}

User Enters Login Credentials
    [Documentation]    This keyword enters username and password into login fields.
    [Arguments]    ${username}    ${password}
    Input Credentials    ${username}    ${login_username_text_box}    ${password}    ${login_password_text_box}


User Registers Username
    [Documentation]    This keyword executes registration process of user, without verification.
    [Arguments]    ${username}    ${password}
    User Navigates To Register Section
    User Enters Registration Credentials    ${username}    ${password}
    Press Register Submit Button

User Should Be Registered
    [Documentation]    This keyword verifies that user is registerd as a user,
    ...    by fetching list of users with javascript and finding username in list.
    [Arguments]    ${username}
    ${userRegistered} =    Execute JavaScript    
    ...    let users = getUsers();
        ...    return users.some(u => u.username === '${username}');
    Should Be True    ${userRegistered}


Log In User
    [Documentation]    This keyword executes and verifies login of user.
    [Arguments]    ${username}    ${password}
    User Navigates To Login Section
    User Enters Login Credentials    ${username}    ${password}
    User Presses Login Button
    User Should Be Logged In    ${username}

User Should Be Logged In
    [Documentation]    This keyword verifies that user is logged in,
    ...    by using javascript to fetch the username of the current logged in user.
    [Arguments]    ${username}
    ${UserLoggedIn} =    Execute JavaScript    return currentUser.username;
    Should Be Equal    ${UserLoggedIn}    ${username}

No One Is Logged In
    [Documentation]    This keyword verifies that no user is currently logged in. If any user is logged in, user is logged out.
    ${test} =     Execute Javascript    if (currentUser) { return true; } else { return false; }
    Run Keyword If    ${test}    Log Out User
    Login Button Should Be Visible

Log Out User
    [Documentation]    This keyword executes and verifies user logout.
    Press Logout Button
    ${alert_text}    Handle Alert    action=DISMISS
    Should Contain    ${alert_text}    ${logout_message}
    Wait Until Element Is Visible    ${login_button}


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



VIP Entrance Ticket is Added To Cart
    [Documentation]    This keyword executes and verifies adding one adult regular ticket to cart.
    Buy Entrance Tickets    ${adult_ticket_type}    ${vip_ticket}    ${1}

Regular Entrance Ticket is Added To Cart
    [Documentation]    This keyword executes and verifies adding one adult VIP ticket to cart.
    Buy Entrance Tickets    ${adult_ticket_type}    ${regular_ticket}    ${1}


User Should Recieve Alert
    [Documentation]    This keyword verifies message of an alert box.
    [Arguments]    ${expected_alert_text}
    ${alert_text}    Handle Alert    action=DISMISS
    Should Contain    ${alert_text}    ${expected_alert_text}

Message Should Be Displayed
    [Documentation]    This keyword verifies that a specific element contains a specific message.  
    [Arguments]    ${element}    ${message}
    Wait Until Element Is Visible    ${element}    ${standard_timeout}
    SeleniumLibrary.Element Text Should Be    ${element}    ${message}

Buy Entrance Tickets
    [Documentation]    This keyword executes and verifies adding entrance ticket(s) to cart. 
    [Arguments]    ${selected_type}    ${selected_category}     ${selected_quantity}
    User Navigates To Buy Ticket Section
    Select From List By Value    ${ticket_field_type}    ${selected_type} 
    Select From List By Value    ${ticket_field_cat}    ${selected_category}
    Input Text  ${ticket_field_quantity}   ${selected_quantity}
    Press Add To Cart Button
     ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}

Buy Entrance Tickets Without Verification
    [Documentation]    This keyword executes and verifies adding entrance ticket(s) to cart, without verification. 
    ...    Error message/alert should be handled elsewhere.   
    [Arguments]    ${selected_type}    ${selected_category}     ${selected_quantity}
    User Navigates To Buy Ticket Section
    Select From List By Value    ${ticket_field_type}    ${selected_type} 
    Select From List By Value    ${ticket_field_cat}    ${selected_category}
    Input Text  ${ticket_field_quantity}   ${selected_quantity}
    Press Add To Cart Button


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

Book Safari Without Verification
    [Documentation]    This keyword executes safari booking process, without verification. 
    ...    Error message/alert should be handled elsewhere.  
        [Arguments]     ${safari_type}    ${safari_date}
    User Navigates To Safari Section
    Input Text    ${safari_date_field}    ${safari_date}
    Select From List By Value    ${safari_type_field}    ${safari_type}
    Click Specific Button    ${safari_submit_button}

Cart Should be Empty
    [Documentation]    This keyword verifies that cart is empty.
    ${cart} =    Execute JavaScript    return getCart();
    Should Be Empty    ${cart}


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
    Press Safari Button
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

User Presses Add To Cart Button
    User Navigates To Buy Ticket Section
    Press Add To Cart Button

User Presses Proceed To Checkout
    [Documentation]    This keyword navigates to cart and presses "Proceed to checkout" button.
    User Navigates To Cart Section
    Press Proceed to checkout button

Login Button Should Be Visible
    Element Should Be Visible    ${login_button}

Logout Button Should Be Visible
    Element Should Be Visible    ${logout_button}

Press Login Button
    Click Specific Button    ${login_button}
    Wait Until Page Contains Element    ${login_section}

Press Ticket Button
    Click Specific Button    ${buy_ticket_button}
    Wait Until Page Contains Element    ${tickets_section}

Press Safari Button
    Click Specific Button    ${safari_button}
    Wait Until Page Contains Element    ${safari_section}

Press Cart Button
    Click Specific Button    ${cart_nav_button}
    Wait Until Page Contains Element    ${cart_section}

Press Logout Button
    Click Specific Button    ${logout_button}
    Sleep    2

Press Register Button
    Click Specific Button    ${reg_button}
    Sleep    2

Press Login Submit Button
    Click Specific Button    ${login_submit_button}
    Sleep    2

Press Add To Cart Button
    Click Specific Button    ${add_to_cart_button}
    Sleep    2

Press Register Submit Button
    Click Specific Button    ${reg_submit_button}
    Sleep    2

Press Proceed To Checkout Button
    Click Specific Button    ${pro_to_checkout_button}
    Sleep    2



Total Cart Cost Should Be Correct
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
    ${datesList} =  Create List 
    ${cart} =    Execute JavaScript    return getCart();
    ${cartLength} =     Get Length    ${cart}
    FOR    ${i}    IN RANGE    0    ${cartLength}
        ${temp} =     Set Variable    ''
        ${date} =     Execute Javascript
        ...    let item = ${cart}[${i}];
        ...    if (item.hasOwnProperty('date')){
        ...        return item.date;    
        ...    }
        ...    else {    
        ...        return "";   
        ...    }

        Run Keyword If    '${date}' != ''    Append To List   ${datesList}    ${date}
    END
    RETURN    ${datesList} 








