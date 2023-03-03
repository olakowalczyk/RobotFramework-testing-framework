*** Settings ***
Resource  ../Common.robot

*** Keywords ***
get Book Appointment button selector
    [Return]  btn-book-appointment
    
get Facility dropdown selector
    [Return]  //*[@id="combo_facility"]

get Apply for hospital readmission checkbox selector
    [Return]  chk_hospotal_readmission

get Healthcare Program option selector
    [Arguments]  ${program_option}
    [Return]  //*[@value="${program_option}"]

get Visit Date input selector
    [Return]  //*[@name="visit_date"]

get Comment input selector
    [Return]  txt_comment

Select Facility
    [Documentation]  Accepts: 
    ...  Tokyo CURA Healthcare Center,
    ...  Hongkong CURA Healthcare Center,
    ...  Seoul CURA Healthcare Center
    [Arguments]  ${facility}
    ${facility_option}=  AppointmentPage.get Facility dropdown selector
    Select From List By Value  ${facility_option}  ${facility} 

Select Healthcare Program  
    [Documentation]  Accepts:  Medicare, Medicaid, None.
    [Arguments]  ${program_option}
    ${program_option}=  AppointmentPage.get Healthcare Program option selector  ${program_option}
    Click element   ${program_option}

Select Visit Date
    [Documentation]  Accepts date in format DD/MM/YYYY
    [Arguments]  ${date}
    ${visit_date_input}=  AppointmentPage.get Visit Date input selector
    Input text  ${visit_date_input}  ${date}
    Click element  ${visit_date_input}
    Common.Confirm selection by clicking on page header

Book appointment
    ${button}=  AppointmentPage.get Book Appointment button selector
    Click element  ${button}
