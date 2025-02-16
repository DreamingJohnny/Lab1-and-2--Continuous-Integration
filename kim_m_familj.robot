*** Settings ***
Library    SeleniumLibrary
Resource    keywords.robot
Resource    keywords.robot
# Setup other variables script here later then?
Variables    variables.py
Variables    kim_specific_variables.py

Test Setup    Setup Suite    ${url_demo}    ${browser}    ${title_demo}    ${kim_username}    ${reg_username_text_box}    ${kim_password}    ${reg_password_text_box}    ${reg_button}    ${reg_submit_button}
Test Teardown    Teardown Suite
*** Test Cases ***
# Check with WV here, shouldn't I just send to their function here instead?
Valid browser login
    Click Specific Button    ${login_button}
	Input Credentials    ${kim_username}    ${login_username_text_box}    ${kim_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}
	#Suggest that sleeptime also becomes variable
	# EDIT seems like it is already, so just remind decide together that we are using it?
	Sleep    3

Buy weekend tickets for 2 adults and 2 children
    Buy More Than One Ticket 

#Buy two adult tickets, check price and date

#Buy two children tickets, check price and date

# Go to page to buy tickets

# Check price

# Buy tickets

	