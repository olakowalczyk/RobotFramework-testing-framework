*** Settings ***
Resource  ../Common.robot


*** Keywords ***
get appointment summary labels selector
    [Return]  //*[@id="summary"]//label

get appointment summary values selector
    [Return]  //*[@id="summary"]//label/../following-sibling::*//p


Get appointment summary labels
    ${sel}=   AppointmentSummaryPage.get appointment summary labels selector
    ${lables}=  Common.Get texts list for given WebElements locator  ${sel}
    [Return]  ${lables}

Get appointment summary values
    ${sel}=   AppointmentSummaryPage.get appointment summary values selector
    ${values}=  Common.Get texts list for given WebElements locator  ${sel}
    [Return]  ${values}

Get appointment summary as a dict
    ${appointment_summary}=  Create dictionary
    ${labels}=  AppointmentSummaryPage.Get appointment summary labels
    ${values}=  AppointmentSummaryPage.Get appointment summary values
    ${lables_len}=  Get length  ${labels}
    FOR  ${i}  IN RANGE  ${lables_len}
        Set to dictionary  ${appointment_summary}   ${labels}[${i}]  ${values}[${i}]
    END
    [Return]  ${appointment_summary}
    