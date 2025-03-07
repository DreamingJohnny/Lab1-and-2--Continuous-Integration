*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Variables    ../util/variables.py

*** Keywords ***

###  Navigation ###

User Navigates To Login Section
    Press Login Button    
    Wait Until Page Contains Element    ${login_section}    5s

User Navigates To Register Section
    Press Register Button
    Wait Until Page Contains Element    ${reg_section}    5s
     
User Navigates To Buy Ticket Section
    Press Ticket Button
    Wait Until Page Contains Element    ${tickets_section}    5s

User Navigates To Safari Section
    Press Safari Button
    Wait Until Page Contains Element    ${safari_section}    5s
 
User Navigates To Cart Section
    Press Cart Button
    Wait Until Page Contains Element    ${cart_section}    5s

### Buttons ###

User Presses Submit Registration Button
    [Documentation]    This keyword executes pressing registration submit button.
    Press Register Submit Button

User Presses Login Submit Button
    [Documentation]    This keyword executes pressing login button.
    Press Login Submit Button

User Presses Safari "Add To Cart" Button
    Press Add Safari To Cart Button

User Presses Ticket "Add To Cart" Button
    Press Add Ticket To Cart Button
    
User Presses Proceed To Checkout
    [Documentation]    This keyword navigates to cart and presses "Proceed to checkout" button.
    User Navigates To Cart Section
    Press Proceed to checkout button

### Buttons should be visible ###

Login Button Should Be Visible
    Element Should Be Visible    ${login_button}

Logout Button Should Be Visible
    Element Should Be Visible    ${logout_button}

### Pressing buttons ###

Press Login Button
    Click Specific Button    ${login_button}
	#TODO: Look into if these should be made more robust, seeing as they are only seeing if the page contains the element (not interactable or visible) and should they maybe in that case be renamed so the name includes the fact that they contain a validation?
    Wait Until Page Contains Element    ${login_section}    5s

Press Ticket Button
    Click Specific Button    ${buy_ticket_button}
    Wait Until Page Contains Element    ${tickets_section}    5s

Press Safari Button
    Click Specific Button    ${safari_button}
    Wait Until Page Contains Element    ${safari_section}    5s

Press Cart Button
    Click Specific Button    ${cart_nav_button}
    Wait Until Page Contains Element    ${cart_section}    5s

Press Logout Button
    Wait Until Element Is Visible    ${logout_button}    2s
    Click Specific Button    ${logout_button}
    # Sleep    2

Press Register Button
    Wait Until Element Is Visible    ${reg_button}    2s
	Click Specific Button    ${reg_button}
    # Sleep    2

Press Login Submit Button
    Wait Until Element Is Visible    ${login_submit_button}    2s
    Click Specific Button    ${login_submit_button}
	# So fascinating, this sleep is needed here, I'm guessing for something to have time to refresh for the JavaScript, but what?
    Sleep    2

Press Add Safari To Cart Button
    Wait Until Element Is Visible    ${safari_submit_button}    2s
    Click Specific Button    ${safari_submit_button}
    # Sleep    2

Press Add Ticket To Cart Button
    Wait Until Element Is Visible    ${add_to_cart_button}    2s
    Click Specific Button    ${add_to_cart_button}
    # Sleep    2

Press Register Submit Button
    Wait Until Element Is Visible    ${reg_submit_button}    2s
    Click Specific Button    ${reg_submit_button}
    # Sleep    2

Press Proceed To Checkout Button
    Wait Until Element Is Visible    ${pro_to_checkout_button}    2s
    Click Specific Button    ${pro_to_checkout_button}
    # Sleep    2

### Page is opened to.. ###

Page Is Opened To Login Page
    [Documentation]    This keyword executes and verifies navigation to login section. 
    User Navigates To Login Section
    Page Should Contain Element    ${login_section}    5s

Page Is Opened To Registration Section
    [Documentation]    This keyword executes and verifies navigation to user registration section.
    Press Register Button
    Page Should Contain Element    ${reg_section}    5s

Page Is Opened To Safari Section
    [Documentation]    This keyword executes and verifies navigation to safari booking section.
    Press Safari Button
    Page Should Contain Element    ${safari_section}    5s

###### From original 

Open Browser To Page
    [Arguments]    ${url}    ${browser}    ${title}
    Open Browser    ${url}    ${browser}
    Title Should Be    ${title}
Click Specific Button
    [Arguments]    ${button}
    Click Element    ${button}