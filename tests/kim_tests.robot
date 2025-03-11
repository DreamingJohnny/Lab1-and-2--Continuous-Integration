# Group 2: Wille, Johan, Kristin 
# This file is created by Johan

*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Process

Resource    ${keyword_path}keywords.robot
Resource    ${keyword_path}kim_keywords.robot


Variables    ${util_path}variables.py
Variables    ${util_path}kim_specific_variables.py

Test Setup    Setup Suite Open Page And Register User    ${kim_username}    ${kim_password}
Test Teardown    Teardown Suite
*** Variables ***
${keyword_path}    ${EXECDIR}/resources/keyword_files/
${util_path}    ${EXECDIR}/resources/util/

*** Test Cases ***

Register User Kim
    [Documentation]    Registers user Kim and verifies that they are a registered user
    [Tags]    Johan-Ahlsten    Registration    Credentials    new-feature
	Given Page Is Opened To Registration Section
    When Kim Enters Registration Credentials
    And User Presses Submit Registration Button
    Then Kim Should be Registered

Log In User Kim
    [Documentation]    Logs in user Kim and verifies that they are logged in
    [Tags]    Johan-Ahlsten    Login    Credentials
    Given Kim Is Registered
    And Page Is Opened To Login Page
    And No One Is Logged In
    When Kim Enters Login Credentials
    And User Presses Login Submit Button
    Then Kim Should Be Logged In

Kim Purchases Tickets For Their Family
    [Documentation]    Logs in as user Kim and buys the specified number of tickets for the family. Verifies that the ticket price in the pop-up is as expected.
    [Tags]    Johan-Ahlsten    Ticket    Popup
    Given Kim Is Logged In To Their Account
    When Kim Buys Tickets For Their Family
	And The User Purchases The Tickets
	Then The Price In The Popup Is Correct    ${kim_expected_ticket_cost_total}

Kim Sees The Correct Price Total On Tickets In Cart
    [Documentation]    Logs in as user Kim and buys the specified number of tickets for the family. Verifies that the total ticket price on the cart is as expected.
    [Tags]    Johan-Ahlsten    Ticket    BookingProcess    Cart    CostTotal
    Given Kim Is Logged In To Their Account
    When Kim Buys Tickets For Their Family
    Then Total Cart Price Should Be Correct    ${kim_expected_ticket_cost_total}

Kim Books Weekend Safaris For Their Family
    [Documentation]    Logs in as user Kim, buys tickets and books safaris. Verifies that the cart shows the expected dates for the safaris.
    [Tags]    Johan-Ahlsten    safari    BookingProcess    new-feature
    Given Kim Is Logged In To Their Account
	And Kim Buys Tickets For Their Family
    When Kim Books Weekend Safaris For Their Family    ${kim_safari_date}
	Then The Date Of Kims Safari Bookings Are Correct

User purchases weekend safaris for their family
    [Documentation]        Logs in as user Kim, buys tickets and books safaris. Verifies that the price of their safari booking in the popup is as expected.
    [Tags]    Johan-Ahlsten    safari    BookingProcess    CostTotal    Popup
    Given Kim Is Logged In To Their Account
	And Kim Buys Tickets For Their Family
    When Kim Books Weekend Safaris For Their Family	${kim_safari_date}
    And The User Purchases The Safaris
	Then The Checkout Summary Alert Should Show Correct Kim Info