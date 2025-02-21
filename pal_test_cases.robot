
*** Settings ***

Library    SeleniumLibrary

Resource    keywords.robot
Resource    pal_keywords.robot

Test Setup    Pal Setup
Test Teardown    Pal Teardown

# This file is created, tested, refactored by Kristin

*** Test Cases ***
    

Register user pal
    [Tags]    Kristin
    Given Page is opened to registration section
    When User pal enters registration credentials
    And User presses register button
    Then User pal is registered    
    
Log in user pal
    [Tags]    Kristin
    Given User pal has registered
    And Page is opened to login page
    And No one is logged in
    When User pal enters login credentials
    And User presses login button
    Then User pal is logged in

Buy entrance ticket
    [Tags]    Kristin
    Given User pal has logged in
    When User navigates to Buy Ticket page
    And Pal buys one adult regular ticket
    Then Pal ticket is added to cart
    And Total cart cost is correct    ${50}

Book safaris
    [Tags]    Kristin
    Given User pal has logged in
    And Pal ticket was added to cart
    When Pal books Herbivore safari without feeding
    And Pal books T-rex tour
    Then Pal safaris are added to cart
    And Total cart cost is correct    ${320}

Checkout
    [Tags]    Kristin
    Given User pal has logged in
    And All Pals items was added to cart
    And Total cart cost is correct    ${320}
    And Dates for safaris are correct
    When User navigates to cart section
    And User presses Proceed To Checkout
    Then Checkout summary alert shows correct Pal info
    And Cart is empty
