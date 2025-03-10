#Kim's user info
kim_username = "kimSvensson"
kim_password = "gatanDarJagVaxteUpp"

#Kim's tickets
kim_number_of_regular_adult_tickets = 1
kim_number_of_VIP_adult_tickets = 1
kim_number_of_VIP_child_tickets = 2
kim_expected_ticket_cost_total = "$270"

#Kim's safari bookings
kim_safari_date = "002026-03-15"
kim_expected_safari_date = "2026-03-15"
kim_expected_vacation_cost_total = "$670"




pal_safari_date_00 = pal_safari_date.strftime(local_safari_date_input_format)   # <<<--- This formatting is crucial for the tests to pass in pipeline
pal_expected_safari_date = pal_safari_date.strftime("%Y-%m-%d")