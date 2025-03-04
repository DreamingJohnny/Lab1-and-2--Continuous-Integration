# This file is written by ChatGPT and refactored by Kristin

import os
import re

# Directory containing the Robot Framework files
keyword_directory = 'resources/keyword_files/'
test_directory = 'tests/'

# The specific tag to remove
tag_to_remove = 'new-feature'

# Regular expression to match the [Tags] section
tag_pattern = r'^\s*\[Tags\].*?\n'


# Function to remove the specific tag from a file
def remove_specific_tag_from_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.readlines()

    cleaned_content = []
    file_changed = False

    for line in content:
        # If line contains the [Tags] section
        if re.match(tag_pattern, line):
            # Remove the specific tag from the tags line
            tags = line.strip().split()
            tags2 = [tag for tag in tags if tag != tag_to_remove]
            if tags != tags2:   #If tag section is changed, write back new tag section
                cleaned_content.append(f"\t{'    '.join(tags2)}\n")
                file_changed = True
            else:    # Else, write line unchanged
                cleaned_content.append(line)
            continue

        # Add the other lines unchanged
        cleaned_content.append(line)

    # If tag was removed, Write the cleaned content back to the file
    if file_changed:
        with open(file_path, 'w', encoding='utf-8') as file:
            file.writelines(cleaned_content)
    
    return  file_changed

# Iterate over all files in the test directory
for filename in os.listdir(test_directory):
    file_path = os.path.join(test_directory, filename)

    # Only process .robot files
    if os.path.isfile(file_path) and filename.endswith('.robot'):
        tag_is_removed = remove_specific_tag_from_file(file_path)
        
        if tag_is_removed:
            print(f"Tag '{tag_to_remove}' removed from {filename}")
        else:
            print(f"No tag '{tag_to_remove}' to remove in {filename}")
            

# Iterate over all files in the keyword directory
for filename in os.listdir(keyword_directory):
    file_path = os.path.join(keyword_directory, filename)

    # Only process .robot files
    if os.path.isfile(file_path) and filename.endswith('.robot'):
        tag_is_removed = remove_specific_tag_from_file(file_path)
        if tag_is_removed:
            print(f"Tag '{tag_to_remove}' removed from {filename}")
        else:
            print(f"No tag '{tag_to_remove}' to remove in {filename}")