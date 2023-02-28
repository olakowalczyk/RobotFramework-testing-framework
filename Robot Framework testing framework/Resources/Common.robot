*** Settings ***
Library   SeleniumLibrary  run_on_failure=Nothing
Library   Collections

Resource  PO/MainPage.robot
Resource  PO/LoginPage.robot
Resource  PO/AppointmentPage.robot


*** Variables ***
${WEB_APP_URL}=      https://katalon-demo-cura.herokuapp.com/
${DEFAULT_TIMEOUT}=  5s


*** Keywords ***
Open app
    Create Webdriver  Chrome
    Go to  ${WEB_APP_URL}
    Maximize browser window

End test
    Run keyword if test Failed  Capture Page Screenshot