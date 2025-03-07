*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Variables    ../util/variables.py

*** Keywords ***

Message Should Be Visible
    [Arguments]    ${error_message_element}    ${error_message_text}    ${timeout}    ${good_mess}
	# Replaces the two rows below
	Wait Until Element Contains    ${error_message_element}    ${good_mess}    ${timeout}
    # Wait Until Element Is Visible    ${error_message_element}    ${timeout}
    # Element Text Should Be    ${error_message_element}    ${good_mess}
    
	Wait Until Element Contains    ${error_message_element}    ${error_message_text}    ${timeout}
	#Wait Until Element Is Visible    ${error_message_element}    ${timeout}
	# So, this is still verifying credentials... so instead it needs to wait until the text is correct...
    #Element Text Should Be    ${error_message_element}    ${error_message_text}

User Should Recieve Alert
    [Documentation]    This keyword verifies message of an alert box.
    [Arguments]    ${expected_alert_text}
    ${alert_text}    Handle Alert    action=DISMISS
    Should Contain    ${alert_text}    ${expected_alert_text}

Message Should Be Displayed
    # TODO: Should Element Text Should Be here maybe instead be contains? Or should otherwise the documentation change?

    [Documentation]    This keyword verifies that a specific element contains a specific message.  
    [Arguments]    ${element}    ${message}
    Wait Until Element Is Visible    ${element}    ${standard_timeout}
    SeleniumLibrary.Element Text Should Be    ${element}    ${message}

User Should Get Message That Username Already Exists
    Message Should Be Displayed    ${reg_message_element}    ${reg_error_message_already_exists}

User Should Get Message That Only VIP User Can Book VIP Safaris
    Message Should Be Displayed    ${safari_message_element}    ${safari_VIP_error_message}

User Should Get Message That VIP Ticket Is Required
    Message Should Be Displayed   ${safari_message_element}    ${safari_weekend_without_VIP_error_message}