*** Settings ***
Documentation       UI-driven end-to-end purchase journeys (registered + guest-to-registered).
Library             SeleniumLibrary
Resource            ../../Resources/Common.robot
Resource            ../../Resources/TestData.robot
Resource            ../../Resources/automationexercise_Res.robot

Suite Setup         Common.Launch Browser
Suite Teardown      Common.Shutdown Browser

*** Test Cases ***
