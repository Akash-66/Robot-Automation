*** Settings ***
Library     RequestsLibrary
Library     ExcellentLibrary
Library     ExcelLibrary

*** Test Cases ***
Keywords Call
    ${CREATE_EXCEL_WORKBOOK_MSG}   CREATE_EXCEL_WORKBOOK    EXCEL_PATH=.\\config\\excel\\Excel_Sheet.xlsx      #Calling CREATE_EXCEL_WORKBOOK keyword (method) with file path parameter and storing return value in variable.
        IF    $CREATE_EXCEL_WORKBOOK_MSG=='PASS'
            ${ROW_HEADER_1}    Create List     S.NO    NAME    AGE      #Creating Header and storing value as list
            WRITE_EXCEL_ROW_DATA    EXCEL_NAME=.\\config\\excel\\Excel_Sheet.xlsx      ROW_NUM=1    DATA=${ROW_HEADER_1}  ID=excel_1    #Calling WRITE_EXCEL_ROW_DATA keyword (method) with parameters and storing return value in variable.
        ELSE
            Log    CREATE_EXCEL_WORKBOOK method failed!!
        END

*** Keywords ***
CREATE_EXCEL_WORKBOOK
    [Arguments]     ${EXCEL_PATH}   #EXCEL_PATH is a parameter of CREATE_EXCEL_WORKBOOK keywords (Parametrised function)
    [Tags]    robot:continue-on-failure
    TRY
        Create Workbook    file_path=${EXCEL_PATH}    overwrite_file_if_exists=True     #It will create Excel_Sheet.xlsx in excel folder
        Save
        Close Workbook
        ${MSG}  Set Variable    PASS
    EXCEPT
         ${MSG}  Set Variable    FAILED
    END
    RETURN  ${MSG}

WRITE_EXCEL_ROW_DATA
    [Arguments]     ${EXCEL_NAME}       ${ROW_NUM}      ${DATA}     ${ID}
    [Tags]    robot:continue-on-failure
    TRY
       Open Excel Document    filename=${EXCEL_NAME}    doc_id=${ID}
       Write Excel Row      row_num=${ROW_NUM}    row_data=${DATA}
       Save Excel Document    filename=${EXCEL_NAME}
       Close Current Excel Document
       ${MSG}  Set Variable    PASS
    EXCEPT
        ${MSG}  Set Variable    FAILED
    END
    RETURN  ${MSG}