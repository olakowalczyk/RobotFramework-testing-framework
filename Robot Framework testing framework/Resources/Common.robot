*** Settings ***
Resource  PO/MainPage.robot
Resource  PO/LoginPage.robot
Resource  PO/AppointmentPage.robot
Library  SeleniumLibrary


*** Variables ***
${WEB_APP_URL}=      https://katalon-demo-cura.herokuapp.com/
${DEFAULT_TIMEOUT}=  5s


*** Keywords ***
Open app
    Create Webdriver  Chrome
    Go to  ${WEB_APP_URL}
    Maximize browser window