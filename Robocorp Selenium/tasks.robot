*** Settings ***
Documentation       Playwright template.

Library             RPA.Browser.Selenium    auto_close=${FALSE}
Library             RPA.HTTP
Library             RPA.Excel.Files
Library             RPA.PDF


*** Tasks ***
Starting with RoboCorp
    Open the intranet website
    Log in
    Download the Excel file
    Fill and submit the first form
    Fill the form using the Excel file data
    Collect results
    Export result to pdf
    [Teardown]    Logout and Close browser


*** Keywords ***
Open the intranet website
    Open Available Browser    https://robotsparebinindustries.com/

Log in
    Input Text    username    maria
    Input Password    password    thoushallnotpass
    Submit Form
    # Wait Until Page Contains Element    id:sales-form

Fill and submit the first form
    Input Text    firstname    Dinesh
    Input Text    lastname    Ravikumar
    Input Text    salesresult    123
    Select From List By Value    salestarget    10000
    Click Button    Submit

Download the Excel file
    Download    https://robotsparebinindustries.com/SalesData.xlsx    overwrite=True

Fill the form using the Excel file data
    Open Workbook    SalesData.xlsx
    ${sales_data}=    Read Worksheet As Table    header=True
    Close Workbook

    FOR    ${single_sale_data}    IN    @{sales_data}
        Fill adnd submit form dynamically    ${single_sale_data}
    END

Fill adnd submit form dynamically
    [Arguments]    ${sales_data}
    Input Text    firstname    ${sales_data}[First Name]
    Input Text    lastname    ${sales_data}[Last Name]
    Input Text    salesresult    ${sales_data}[Sales]
    Select From List By Value    salestarget    ${sales_data}[Sales Target]
    Click Button    Submit

Collect results
    Screenshot    css:div.sales-summary    ${OUTPUT_DIR}${/}sales_summary.png

Export result to pdf
    Wait Until Element Is Visible    id:sales-results
    ${sales_result_html}=    Get Element Attribute    id:sales-results    outerHTML
    Html To Pdf    ${sales_result_html}    ${OUTPUT_DIR}${/}sales_results.pdf

Logout and Close browser
    Click Button    Log out
    Close Browser
