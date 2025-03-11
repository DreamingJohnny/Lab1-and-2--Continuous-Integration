import locale
from datetime import date, timedelta

def get_date_format():
    """
    Determine the date format based on the system's locale.
    Returns the date format string.
    """
    loc = locale.getdefaultlocale()[0]
    if loc == 'en_US':
        return "%m/%d/%Y"  # US format
    else:
        return "%Y-%m-%d"  # Default to Swedish format
    

def get_date_format_00():
    """
    Determine the date format based on the system's locale.
    Returns the date format string.
    If format is yyyy-m-dd, two zeroes are added initially to fit date input format. 
    """
    loc = locale.getdefaultlocale()[0]
    if loc == 'en_US':
        return "%m/%d/%Y"  # US format
    else:
        return "00%Y-%m-%d"  # Default to Swedish format

