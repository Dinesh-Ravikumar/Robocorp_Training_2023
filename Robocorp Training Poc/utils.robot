*** Keywords ***
concad-two-strings
    [Arguments]    ${string1}    ${string2}
    ${res_string}=    Catenate    Separator=---    ${string1}    ${string2}
    Log To Console    ${res_string}
    RETURN    ${res_string}
