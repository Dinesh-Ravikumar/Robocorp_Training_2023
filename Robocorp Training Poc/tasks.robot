*** Settings ***
Documentation       Playwright template.

# Library    RPA.Browser.Playwright
Library             Collections
Library             String
Resource            utils.robot
Library             dynamicVariables.py

# Variables    variables.py
Suite Setup         Log    Open Browser
Suite Teardown      Log    Close Browser
# Scalar Variable -> String, Number
# Vector Variable -> List, Dictionary(Key: Value)


*** Variables ***
# String Variable
${employee_name}=       Dinesh
# Number Variable
${age}=                 ${21}    # To get rid of the value to be taken as string, the number was surrounded with curly braces
# List Variable
@{spoken_languages}=    English    Tamil
# Dictionary Variables
&{employee_map}=        employee_name=${employee_name}    employee_age=${age}    languages=@{spoken_languages}


*** Tasks ***
Robocorp Trainng
    dictionary variable


*** Keywords ***
concat string with hyphens
    ${res_string}=    concad-two-strings    Hello    Dinesh R

remove duplicates from list
    ${e_list}=    Create List    100    200    100    200    120    110
    # Log To Console    ${e_list}
    ${modified-list}=    Remove Duplicates    ${e_list}
    Log To Console    ${modified-list}
    FOR    ${current}    IN    ${e_list}, ${modified-list}
        Log To Console    ${current}
    END

variables usage
    [Documentation]    variables usage
    # @ -> unpacking the list
    # $ -> Container reference
    # & -> Unpacking the dictionary
    # % -> is used for environment variables

    # Log To Console    ${spoken_languages}
    # Log To Console    ${employee_name}
    # Log To Console    ${age}
    # Log To Console    ${employee_map}[employee_name]
    FOR    ${key}    ${value}    IN    &{employee_map}
        Log To Console    key->>> ${key}
        Log To Console    value->>> ${value}
    END

list variable manipulation
    @{base}=    Create List    alpha    beta
    Log To Console    Base value->>> ${base}
    Append To List    ${base}    gamma
    Log To Console    After appending ->>> ${base}

dictionary variable
    Log To Console    ${employee_map}[languages][0]
    Log To Console    ${employee_map.languages[1]}
    ${var}=    Ret Tru    ${employee_map.languages[1]}
    Log To Console    ${var}
