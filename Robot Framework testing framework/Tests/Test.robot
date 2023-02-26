*** Settings ***
Documentation  This is an example of BDD testing in RobotFramework 
Resource  ../Resources/Common.robot
Suite Setup  Common.Open app
Suite Teardown  Close browser

*** Variables ***
${USERNAME}=  John Doe
${PASSWORD}=  ThisIsNotAPassword


*** Test Cases ***
Test-1: Login to CURA selfcare service
    [Tags]  test-1  critical
    GIVEN Main page is available
    WHEN Users goes to Login page
    AND User enters login credentials
    AND User clicks on Login button
    THEN User is successfully logged in


*** Keywords ***
Main page is available
    ${main_page}=  MainPage.get main page Make Appointment button selector
    Wait Until Element Is Visible  ${main_page}  timeout=${DEFAULT_TIMEOUT}

Users goes to Login page
    MainPage.Go to Login page

User enters login credentials
    LoginPage.Enter login credentials  ${USERNAME}  ${PASSWORD}

User clicks on Login button
    LoginPage.Click on Login button

User is successfully logged in
    ${appointment_page}=  AppointmentPage.get Book Appointment button selector
    Wait Until Element Is Visible  ${appointment_page}  timeout=${DEFAULT_TIMEOUT}
