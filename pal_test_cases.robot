*** Settings ***
Library    SeleniumLibrary
Resource    keywords.robot
Resource    pal_keywords.robot

Variables    variables.py
Variables    pal_specific_variables.py


#Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${pal_username}    ${reg_username_text_box}    ${pal_password}    ${reg_password_text_box}    ${reg_button}    ${reg_submit_button}
#Test Teardown    Teardown Suite

*** Variables ***
@{fruits}    Apple    Banana    Cherry    Date


*** Test Cases ***


Register user pal
    [Tags]    Kristin
    Open Browser    ${url_demo}    ${browser}    ${title_demo}
    Click Specific Button    ${reg_button}
    Given Page is opened to registration section
    When User pal enters registration credentials
    And User presses register button
    Then User pal is registered    
    
Log in user pal
#    Open Browser    ${url_demo}    ${browser}    ${title_demo}
#    Click Specific Button    ${login_button}
    Given User pal is registered
    And Page is opened to login page
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
    And Pal ticket is added to cart
    And Pal safaris are added to cart
    And Total cart cost is correct    ${320}
    And Dates for safaris are the same
    And User navigates to cart section
    When User presses Proceed To Checkout
    Then Checkout summary alert shold show with correct Pal info
    And Cart is empty
