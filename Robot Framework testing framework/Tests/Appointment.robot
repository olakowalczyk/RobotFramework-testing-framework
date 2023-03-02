*** Settings ***
Documentation  This is an example of BDD testing in RobotFramework 
Resource  ../Resources/Common.robot
Suite Setup  Common.Open app
Test Teardown  Common.End test
Suite Teardown  Close browser


*** Test Cases ***
Test-3: Make appointment
    [Tags]  test-3  critical
    [Setup]  Run keywords
    ...       MainPage.Go to Login page
    ...  AND  LoginPage.Enter login credentials  ${USERNAME}  ${PASSWORD}
    ...  AND  LoginPage.Click on Login button
    GIVEN User is on Appointment page
    WHEN User selects Facility  Seoul CURA Healthcare Center
    AND User selects Healthcare Program  Medicaid
    AND User selects current date as Visit Date
    AND Users enters a comment
    AND User clicks on Book Appointment button
    THEN Appointment confirmation is displayed


*** Keywords ***
User is on Appointment page
    ${main_page}=  MainPage.get main page Make Appointment button selector
    Wait Until Element Is Visible  ${main_page}  timeout=${DEFAULT_TIMEOUT}

User selects Facility
    [Arguments]  ${facility}
    AppointmentPage.Select Facility  ${facility}
    Set test variable  ${EXPECTED_FACILITY}  ${facility}

User selects Healthcare Program
    [Arguments]  ${program}
    AppointmentPage.Select Healthcare Program  ${program}
    Set test variable  ${EXPECTED_PROGRAM}  ${program}

User selects current date as Visit Date
    ${current_date}=  Get current date  result_format=%d/%m/%Y
    AppointmentPage.Select Visit Date  ${current_date}
    Set test variable  ${EXPECTED_DATE}  ${current_date}

Users enters a comment
    [Arguments]  ${comment_text}=This is just test text.
    ${comment_input}=  AppointmentPage.get Comment input selector
    Input text  ${comment_input}  ${comment_text}
    Set test variable  ${EXPECTED_COMMENT}  ${comment_text}

User clicks on Book Appointment button
    AppointmentPage.Book appointment

Appointment confirmation is displayed
    [Arguments]  ${facility}=${EXPECTED_FACILITY}  ${healthcare_program}=${EXPECTED_PROGRAM}  
    ...  ${date}=${EXPECTED_DATE}  ${comment}=${EXPECTED_COMMENT}
    ${appointment_summary}=  AppointmentSummaryPage.Get appointment summary as a dict
    Log dictionary  ${appointment_summary}
    Should be equal as strings  ${appointment_summary}[Facility]  ${facility}
    Should be equal as strings  ${appointment_summary}[Healthcare Program]  ${healthcare_program}
    Should be equal as strings  ${appointment_summary}[Visit Date]  ${date}
    Should be equal as strings  ${appointment_summary}[Comment]  ${comment}

