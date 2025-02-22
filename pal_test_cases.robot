
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
    [Documentation]    This test verifies the registration process for user pal.
    [Tags]    Kristin    Registration    Credentials
    Given Page Is Opened To Registration Section
    When User Pal Enters Registration Credentials
    And User Presses Register Button
    Then User Pal Is Registered    
    
Log in user pal
    [Documentation]    This test verifies the login process for user pal.
    [Tags]    Kristin    Login    Credentials
    Given User Pal Has Registered
    And Page Is Opened To Login Page
    And No One Is Logged In
    When User Pal Enters Login Credentials
    And User Presses Login Button
    Then User Pal Is Logged In

Buy entrance ticket
    [Documentation]    This test verifies that pal can buy entrance ticket when logged in,
    ...    that item is added to cart, and cart total is correct.
    [Tags]    Kristin    Ticket    BookingProcess    Cart    CostTotal
    Given User Pal Has Logged In
    When Pal Buys Entrance Ticket
    Then Pal Entrance Ticket Is Added To Cart
    And Total Cart Cost Is Correct    ${50}

Book safaris
    [Documentation]    This test verifies the safari booking process for user pal, 
    ...    and that cart total price is correct.
    [Tags]    Kristin    Safari    BookingProcess    Cart    CostTotal    Demo
    Given User Pal Has Logged In
    And Pal Entrance Ticket Was Added To Cart
    When Pal Books Safaris 
    Then Pal Safaris Are Added To Cart
    And Total Cart Cost Is Correct    ${320}

Checkout
    [Documentation]    This test verifies the checkout process for user pal, and that summary is correct.
    [Tags]    Kristin   Cart   CostTotal    Checkout    Dates    Summary    Demo
    Given User Pal Has Logged In
    And Pals Items Was Added To Cart
    And Total Cart Cost Is Correct    ${320}
    And Dates For Safaris Are Correct
    When User Presses Proceed To Checkout
    Then Checkout Summary Alert Shows Correct Pal Info
    And Cart Is Empty
