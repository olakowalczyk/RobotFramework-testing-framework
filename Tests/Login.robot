*** Settings ***
Documentation  This is an example of BDD testing in RobotFramework 
Resource  ../Resources/Common.robot
Suite Setup  Common.Open app
Test Teardown  Common.End test
Suite Teardown  Close browser


*** Test Cases ***
Test-1: Invalid login to CURA selfcare service
    [Tags]  test-1  critical
    [Template]  Template - Invalid credentials
#   ${username}         ${password}
    invalid_username    ${PASSWORD}
    ${USERNAME}         invalid_pass
    ${EMPTY}            ${PASSWORD}
    ${USERNAME}         ${EMPTY}

Test-2: Valid login to CURA selfcare service
    [Tags]  test-2  critical
    GIVEN User is on Appointment page
    WHEN User goes to Login page
    AND User enters login credentials
    AND User clicks on Login button
    THEN User is successfully logged in
    AND User has expected options available in the menu  Home  History  Profile  Logout


*** Keywords ***
Template - Invalid credentials
    [Arguments]  ${username}  ${password} 
    GIVEN User is on Appointment page
    WHEN User goes to Login page
    AND User enters login credentials  ${username}  ${password}
    AND User clicks on Login button
    THEN Expected validation message is displayed to user

User is on Appointment page
    ${main_page}=  MainPage.get main page Make Appointment button selector
    Wait Until Element Is Visible  ${main_page}  timeout=${DEFAULT_TIMEOUT}

User goes to Login page
    MainPage.Go to Login page

User enters login credentials
    [Arguments]  ${username}=${USERNAME}  ${password}=${PASSWORD}
    LoginPage.Enter login credentials  ${username}  ${password} 

User clicks on Login button
    LoginPage.Click on Login button

User is successfully logged in
    ${appointment_page}=  AppointmentPage.get Book Appointment button selector
    Wait Until Element Is Visible  ${appointment_page}  timeout=${DEFAULT_TIMEOUT}

User has expected options available in the menu
    [Arguments]  @{expected_options} 
    MainPage.Expand Menu if hidden
    ${current_options}=  MainPage.Get available menu options
    Lists should be equal  ${current_options}  ${expected_options}  msg=List of available options is not as expected!

Expected validation message is displayed to user
    [Arguments]  ${expected_msg_alias}=Login failed
    ${expected_msg}=  Run keyword  MainPage.get ${expected_msg_alias} message
    ${error_msg}=  MainPage.get Login failed message selector
    Element should be visible  ${error_msg}  msg=Error message is not displayed at all!
    ${current_error_msg}=  Get text  ${error_msg}
    Should be equal as strings  ${current_error_msg}  ${expected_msg}  msg=Validation message is not as expected!
