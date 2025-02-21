
*** Settings ***

Library    SeleniumLibrary

Resource    keywords.robot
Resource    pal_keywords.robot

Suite Setup    Pal Setup
Suite Teardown    Pal Teardown

# This file is created, tested, refactored by Kristin
# Tests are to run in a suite

*** Test Cases ***
    

Register user pal
    Given Page is opened to registration section
    When User pal enters registration credentials
    And User presses register button
    Then User pal is registered    
    
Log in user pal
    Given User pal is registered
    And Page is opened to login page
    And No one is logged in
    When User pal enters login credentials
    And User presses login button
    Then User pal is logged in

Buy entrance ticket
    Given User pal is logged in
    When User navigates to Buy Ticket page
    And Pal buys one adult regular ticket
    Then Pal ticket is added to cart
    And Total cart cost is correct    ${50}

Book safaris
    Given User pal is logged in
    And Pal ticket is added to cart
    When Pal books Herbivore safari without feeding
    And Pal books T-rex tour
    Then Pal safaris are added to cart
    And Total cart cost is correct    ${320}

Checkout
    Given User pal is logged in
    And All Pals items are in cart
    And Total cart cost is correct    ${320}
    And Dates for safaris are correct
    When User navigates to cart section
    And User presses Proceed To Checkout
    Then Checkout summary alert shows correct Pal info
    And Cart is empty
