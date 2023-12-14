# CLIPS Rule Generator

## Description
This Python program, integrated with the CLIPS expert system, serves as a dynamic recruitment matching tool. It reads applicant data from a CSV file, stores it in a custom Applicant class, and utilizes CLIPS rules for filtering candidates based on various criteria.

##  Usage
**Data Loading:** Reads applicant data from 'stackoverflow_full.csv' and populates the CLIPS environment.

**Interactive Search:** Users input various search criteria, and the system dynamically generates and applies CLIPS rules to filter applicants.

**Display Results:** Presents the matching applicants and their details based on the applied filters.

## Requirements
Python 3.10 or higher
CLIPS Python library

## Setup
Ensure Python 3.10 and the CLIPS Python library are installed. (clipspy currently not supported in Silicon Chips)
Place the 'stackoverflow_full.csv' file in the same directory as the script.
Run the script using a Python interpreter.

## Note
This system is designed for simplicity and ease of use. It can be extended or modified for more complex recruitment processes.