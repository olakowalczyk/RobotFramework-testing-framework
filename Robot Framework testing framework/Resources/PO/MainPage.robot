*** Settings ***
Resource  ../Common.robot

*** Keywords ***
get main page Make Appointment button selector
    [Return]  btn-make-appointment

get menu button selector
    [Return]  menu-toggle

get menu panel selector
    [Documentation]  By defualt returns expanded menu panel selector
    [Arguments]  ${active}=${TRUE}
    IF  ${active}
        RETURN  //*[@id="sidebar-wrapper"][@class="active"]
    ELSE
        RETURN  sidebar-wrapper
    END

get menu option selector
    [Documentation]  Accepts ${option}: Home, Login, Profile, Logout or ALL
    [Arguments]  ${option}
    IF  "${option}"=="ALL"
        RETURN  //*[@id="sidebar-wrapper"]//li[text()][not(@class)]
    ELSE
        RETURN  //*[@id="sidebar-wrapper"]//*[text()="${option}"]
    END

get Login failed message selector
    [Return]  //*[@class="lead text-danger"]

get Login failed message
    [Return]  Login failed! Please ensure the username and password are valid.


Go to Login page
    MainPage.Expand Menu if hidden
    ${login_option}=  MainPage.get menu option selector  Login
    ${login_button}=  LoginPage.get Login button selector
    Click element  ${login_option}
    Wait until element is visible  ${login_button}

Expand Menu if hidden
    ${menu_button}=  MainPage.get menu button selector
    ${menu_panel}=  MainPage.get menu panel selector
    ${is_menu_panel_hidden}=  Run keyword and return status  Element should be visible  ${menu_panel}
    IF  ${is_menu_panel_hidden}==${FALSE}  Click element  ${menu_button}
    Wait until element is visible  ${menu_panel}
    
Get available menu options
    ${options_sel}=  MainPage.get menu option selector  ALL
    ${elements}=  Get WebElements  ${options_sel}
    ${current_options}=   Create list
    FOR  ${el}  IN  @{elements}
        ${option_name}=  Get text  ${el}
        Append to list  ${current_options}  ${option_name}
    END
    [Return]  ${current_options}