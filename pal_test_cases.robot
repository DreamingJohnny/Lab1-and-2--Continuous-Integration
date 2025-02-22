
# Group 3: Wille, Johan, Kristin 
# This file is created, tested, refactored by Kristin

*** Settings ***

Library    SeleniumLibrary

Resource    keywords.robot
Resource    pal_keywords.robot

Test Setup    Pal Setup
Test Teardown    Pal Teardown


*** Test Cases ***
    

Register user pal
    [Documentation]    This test verifies registration process for user pal.
    [Tags]    Kristin
    Given Page is opened to registration section
    When User pal enters registration credentials
    And User presses register button
    Then User pal is registered    
    
Log in user pal
    [Documentation]    This test verifies login process for user pal.
    [Tags]    Kristin    
    Given User pal has registered
    And Page is opened to login page
    And No one is logged in
    When User pal enters login credentials
    And User presses login button
    Then User pal is logged in

Buy entrance ticket
    [Documentation]    This test verifies that pal can buy entrance ticket,
    ...    that item is added to cart, and cart total is correct.
    [Tags]    
    Given User pal has logged in
    When Pal buys entrance ticket
    Then Pal ticket is added to cart
    And Total cart cost is correct    ${50}

Book safaris
    [Documentation]    This test verifies that the safari booking process for user pal, 
    ...    and that cart total price is correct.
    [Tags]    Kristin
    Given User pal has logged in
    And Pal ticket was added to cart
    When Pal books safaris 
    Then Pal safaris are added to cart
    And Total cart cost is correct    ${320}

Checkout
    [Documentation]    This test verifies the checkout process for user pal.
    [Tags]    Kristin
    Given User pal has logged in
    And Pals items was added to cart
    And Total cart cost is correct    ${320}
    And Dates for safaris are correct
    When User presses Proceed To Checkout
    Then Checkout summary alert shows correct Pal info
    And Cart is empty
