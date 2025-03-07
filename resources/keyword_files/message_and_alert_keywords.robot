*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Variables    ../util/variables.py

*** Keywords ***

User Should Recieve Expected Message
    [Documentation]    Verifies that a element is visible within timout and contains the expected text
    [Arguments]    ${message_element}    ${expected_text}
    Wait Until Element Is Visible    ${message_element}    ${standard_timeout}
    Element Should Contain    ${message_element}    ${expected_text}

User Should Recieve Alert With Expected Text
    [Documentation]    This keyword verifies that the message of an alert box contains the expected text. Also dismisses the alert.

    [Arguments]    ${expected_alert_text}
    ${alert_text}    Handle Alert    DISMISS    ${standard_timeout}
    Should Contain    ${alert_text}    ${expected_alert_text}

User Should Get Message That Username Already Exists
    User Should Recieve Expected Message    ${reg_message_element}    ${reg_error_message_already_exists}

User Should Get Message That Only VIP User Can Book VIP Safaris
    User Should Recieve Expected Message    ${safari_message_element}    ${safari_VIP_error_message}

User Should Get Message That VIP Ticket Is Required
    User Should Recieve Expected Message   ${safari_message_element}    ${safari_weekend_without_VIP_error_message}