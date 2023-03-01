*** Settings ***
Library   SeleniumLibrary  run_on_failure=Nothing
Library   Collections
Library   DateTime

Resource  PO/MainPage.robot
Resource  PO/LoginPage.robot
Resource  PO/AppointmentPage.robot
Resource  PO/AppointmentSummaryPage.robot


*** Variables ***
${WEB_APP_URL}=      https://katalon-demo-cura.herokuapp.com/
${DEFAULT_TIMEOUT}=  5s
${USERNAME}=  John Doe
${PASSWORD}=  ThisIsNotAPassword


*** Keywords ***
get page header selector
    [Return]  top


Open app
    Create Webdriver  Chrome
    Go to  ${WEB_APP_URL}
    Maximize browser window

End test
    Run keyword if test Failed  Capture Page Screenshot

Confirm selection by clicking on page header
    ${header}=  Common.get page header selector
    Click element  ${header}

Get texts list for given WebElements locator
    [Documentation]  Returns list of texts for given WebElements locator.
    [Arguments]  ${selector}
    ${result}=  Create list
    ${els}=  Get WebElements  ${selector}
    FOR  ${el}  IN  @{els}
        ${text}=  Get text  ${el}
        Append to list  ${result}  ${text}
    END
    [Return]  ${result}
