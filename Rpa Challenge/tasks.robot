*** Settings ***
Documentation       Reads the local excel file and applies it to the rpa challenge.

Library             RPA.Browser.Playwright
Library             RPA.Excel.Files
Library             String


*** Variables ***
# ${excel_data}=    ${EMPTY}


*** Tasks ***
Process
    Open the browser
    Read excel file and fill


*** Keywords ***
Start challenge
    Click    //button[@class="waves-effect col s12 m12 l12 btn-large uiColorButton"]

Read excel file and fill
    Open Workbook    challenge.xlsx
    ${excel_data}=    Read Worksheet As Table    header=True
    Close Workbook
    FOR    ${element}    IN    @{excel_data}
        # Fill in rpa challenge    ${element}
        FOR    ${key}    ${value}    IN    &{element}
            Fill in challenge dynamic    ${key}    ${value}
        END
        Click    //input[@value="Submit"]
    END
    Sleep    5s

Open the browser
    Open Browser    https://rpachallenge.com/

Fill in challenge dynamic
    [Arguments]    ${key}    ${value}
    IF    '${key}' == 'Role in Company'
        Fill Text    //input[@ng-reflect-name="labelRole"]    ${value}
    ELSE IF    '${key}' == 'Phone Number'
        Fill Text    //input[@ng-reflect-name="labelPhone"]    ${value}
    ELSE
        ${removed_string}=    Replace String    ${key}    ${SPACE}    ${EMPTY}
        Fill Text    //input[@ng-reflect-name="label${removed_string}"]    ${value}
    END
