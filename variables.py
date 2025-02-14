import os

current_directory = os.getcwd().replace('\\', '/')

browser = "chrome"
url_demo = f"file:///{current_directory}/Homepage\jurap.html"
title_demo = "Jura-Stina-Kalle Park"
login_button = "login-nav"
valid_username = "testUser2"
valid_password = "testPassword2"
invalid_username = "XXXXXXXX"
invalid_password = "YYYYYYYY"
login_username_text_box = "login-username"
login_password_text_box = "login-password"
error_message_element_demo = "id=login-message"
error_message_demo = "Invalid username or password."
standard_timeout = "10s"
verifying_messege = "Verifying credentials..."
reg_button = "xpath=/html/body/header/div/nav/ul/li[2]/a"
reg_username_text_box = "reg-username"
reg_password_text_box = "reg-password"
logout_button = "logout-link"




