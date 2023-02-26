*** Settings ***
Resource  ../Common.robot

*** Keywords ***
get Login button selector
    [Return]  btn-login

get login input selector
    [Return]  txt-username

get password input selector
    [Return]  txt-password


Enter login
    [Arguments]  ${username}
    ${login_input}=  LoginPage.get login input selector
    Input text  ${login_input}  ${username}

Enter password
    [Arguments]  ${password}
    ${password_input}=  LoginPage.get password input selector
    Input text  ${password_input}  ${password}

Enter login credentials 
    [Arguments]  ${username}  ${password}
    LoginPage.Enter login  ${username}
    LoginPage.Enter password  ${password}

Click on Login button
    ${login_button}=  get Login button selector
    Click element  ${login_button}
