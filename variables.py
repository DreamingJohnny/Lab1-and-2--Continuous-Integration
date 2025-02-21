import os

current_directory = os.getcwd().replace('\\', '/')
#Site specifics
browser = "chrome"
url_demo = f"file:///{current_directory}/Homepage\jurap.html"
title_demo = "Jura-Stina-Kalle Park"
#Sections
home_section = "id=home-section"
login_section = "id=login-section"
reg_section = "id=register-form"
tickets_section = "id=tickets-section"
safari_section = "id=safari-section"
cart_section = "id=safari-section"
#Login specifics
login_button = "login-nav"
login_username_text_box = "login-username"
login_password_text_box = "login-password"
#Valid login
valid_username = "testUser2"
valid_password = "testPassword2"
verifying_message = "Verifying credentials..."
login_submit_button = "xpath=/html/body/main/article[3]/section/form/button"
#Invalid login
invalid_username = "XXXXXXXX"
invalid_password = "YYYYYYYY"
error_message_element_demo = "id=login-message"
error_message_demo = "Invalid username or password."
#Registration
reg_button = "xpath=/html/body/header/div/nav/ul/li[2]/a"
reg_username_text_box = "reg-username"
reg_password_text_box = "reg-password"
reg_submit_button = "xpath=/html/body/main/article[2]/section/form/button"
reg_message_element = "id=register-message"
reg_success_message = "Registration successful! Redirecting to login..."
#Misc
standard_timeout = "5s"
logout_button = "logout-link"
#Buying tickets
buy_ticket_button = "xpath=/html/body/header/div/nav/ul/li[4]/a"
ticket_type_field = "xpath=/html/body/main/article[4]/section/form/select[1]"
adult_ticket_type = "Adult"
regular_adult_ticket_price = 50
child_ticket_type = "Child"
regular_child_ticket_price = 30
senior_ticket_type = "Senior"
ticket_cat_field = "xpath=/html/body/main/article[4]/section/form/select[2]"
regular_ticket = "Regular"
vip_ticket = "VIP"
vip_adult_ticket_price = 100
vip_child_ticket_price = 60
add_to_cart_button = "xpath=/html/body/main/article[4]/section/form/button"
add_to_cart_message_successful = "Item added to cart!"
input_of_ticket_counter = "id=ticket-quantity"
cart_nav_button = "xpath=/html/body/header/div/nav/ul/li[6]"
pro_to_checkout_button = "xpath=/html/body/main/article[6]/section/button"
#Booking safaris
safari_button = "xpath=/html/body/header/div/nav/ul/li[5]/a"
safari_date_field = "id=safari-date"
date_for_booking = "002025-02-20"
safari_type_field = "xpath=/html/body/main/article[5]/section/form/select"
safari_type_herbivor_tour = "Herbivore Tour"
safari_type_t_rex_rumble = "T-Rex Rumble"
safari_type_herbivor_tour_feeding = "Herbivore Tour with Feeding"
safari_herbivor_tour_feeding_price = 180
safari_type_t_rex_rumble_thrill = "T-Rex Rumble eXtreme Thrill Pack"
safari_t_rex_rumble_thrill_price = 220
safari_submit_button = "xpath=/html/body/main/article[5]/section/form/button"
#Removing from cart
first_object_in_cart = "xpath=/html/body/main/article[6]/section/div/ul/li[1]/button"
second_object_in_cart = "xpath=/html/body/main/article[6]/section/div/ul/li[2]/button"

#Shopping cart
#TODO: Check, is it necessary to have xpath= in the beginning here to help the system read it?
cart_total_xpath = "xpath=//*[@id=\"cart-total\"]"

cart_tab_xpath = "xpath=//*[@id=\"cart-nav\"]"

cart_list_xpath = "xpath=//*[@id=\"cart-details\"]/ul/li"

proceed_to_checkout_button = "xpath=//*[@id=\"checkout-button\"]"


