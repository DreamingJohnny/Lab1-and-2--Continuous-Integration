*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Variables    ${util_path}variables.py
*** Variables ***
${util_path}    ${EXECDIR}/resources/util/


*** Keywords ***

###  Navigation ###

User Navigates To Login Section
    Press Login Button    

User Navigates To Register Section
    Press Register Button
     
User Navigates To Buy Ticket Section
    Press Ticket Button

User Navigates To Safari Section
    Press Safari Button
    
User Navigates To Cart Section
    Press Cart Button

### Buttons ###

User Presses Submit Registration Button
    [Documentation]    This keyword executes pressing registration submit button.
    Press Register Submit Button

User Presses Login Submit Button
    [Documentation]    This keyword executes pressing login button.
    Press Login Submit Button
	Wait Until Element Is Visible    ${logout_button}    ${standard_timeout}

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
    Click Element    ${login_button}
    Wait Until Element Is Visible    ${login_section}    ${standard_timeout}

Press Ticket Button
    Click Element    ${buy_ticket_button}
    Wait Until Element Is Visible     ${tickets_section}    ${standard_timeout}

Press Safari Button
    Click Element    ${safari_button}
    Wait Until Element Is Visible    ${safari_section}    ${standard_timeout}

Press Cart Button
    Click Element    ${cart_nav_button}
    Wait Until Element Is Visible    ${cart_section}    ${standard_timeout}

Press Logout Button
	Wait Until Element Is Enabled    ${logout_button}    ${standard_timeout}
    Click Element    ${logout_button}

Press Register Button
    Wait Until Element Is Enabled    ${reg_button}    ${standard_timeout}
	Click Element    ${reg_button}

Press Login Submit Button
    Wait Until Element Is Enabled    ${login_submit_button}    ${standard_timeout}
    Click Element    ${login_submit_button}

Press Add Safari To Cart Button
    Wait Until Element Is Enabled    ${safari_submit_button}    ${standard_timeout}
    Click Element    ${safari_submit_button}

Press Add Ticket To Cart Button
    Wait Until Element Is Enabled    ${add_to_cart_button}    ${standard_timeout}
    Click Element    ${add_to_cart_button}

Press Register Submit Button
    Wait Until Element Is Enabled    ${reg_submit_button}    ${standard_timeout}
    Click Element    ${reg_submit_button}

Press Proceed To Checkout Button
    Wait Until Element Is Enabled    ${pro_to_checkout_button}    ${standard_timeout}
    Click Element    ${pro_to_checkout_button}

### Page is opened to.. ###

Page Is Opened To Login Page
    [Documentation]    This keyword executes and verifies navigation to login section. 
    User Navigates To Login Section
	# I'm changing these to element visible, I think they are more robust, and better checks what we want to verify
    Wait Until Element Is Visible    ${login_section}    ${standard_timeout}

Page Is Opened To Registration Section
    [Documentation]    This keyword executes and verifies navigation to user registration section.
    Press Register Button
    Wait Until Element Is Visible    ${reg_section}    ${standard_timeout}

Page Is Opened To Safari Section
    [Documentation]    This keyword executes and verifies navigation to safari booking section.
    Press Safari Button
    Wait Until Element Is Visible    ${safari_section}    ${standard_timeout}

###### From original 

Open Browser To Page
    [Arguments]    ${url}    ${browser}    ${title}
    Open Browser    ${url}    ${browser}
    Title Should Be    ${title}