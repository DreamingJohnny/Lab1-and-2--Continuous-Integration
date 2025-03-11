# Group 2: Wille, Johan, Kristin 
# This file is created by Kristin
import datetime
import check_date

pal_username = "StinaPalle"
pal_password = "thePaleontoligist"

pal_expected_cost_ticket = 50
pal_expected_cost_total = 320

pal_ticket_type = "Adult"
pal_ticket_category = "Regular"
pal_number_of_tickets = "1"


pal_ticket_price = 50
pal_safari1_price = 120
pal_safari2_price = 150


### Format Pal's safari dates 
local_safari_date_input_format = check_date.get_date_format_00()
local_safari_date_expected_format = check_date.get_date_format()


pal_safari_date = datetime.date(2026,3,19) # date format
pal_safari_date_00 = pal_safari_date.strftime(local_safari_date_input_format)   # If date format is yyyy-mm-dd, '00' is added at start of string to fit date input format
#pal_expected_safari_date = pal_safari_date.strftime(local_safari_date_expected_format) # string format
pal_expected_safari_date = pal_safari_date.strftime("%Y-%m-%d") # string format

### Pal checkout summary ###
pal_ticket_description = "1 Regular Adult Ticket(s)"
pal_safari1_description = "Herbivore Tour"
pal_safari2_description = "T-Rex Rumble"

pal_safari1_description_with_date = f"{pal_safari1_description} on {pal_expected_safari_date}"
pal_safari2_description_with_date = f"{pal_safari2_description} on {pal_expected_safari_date}"

pal_ticket_description_with_price = f"{pal_ticket_description} - ${pal_ticket_price}"
pal_safari1_description_with_date_and_price = f"{pal_safari1_description} on {pal_expected_safari_date} - ${pal_safari1_price}"
pal_safari2_description_with_date_and_price = f"{pal_safari2_description} on {pal_expected_safari_date} - ${pal_safari2_price}"
pal_total_desctiption_full = f"Total: ${pal_expected_cost_total}"


# Checkout Summary should be: 
# 1 Regular Adult Ticket(s) - $50 
# Herbivore Tour on 2025-03-19 - $120 
# T-Rex Rumble on 2025-03-19 - $150 
# Total: $320


