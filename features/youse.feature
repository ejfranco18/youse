Feature: Enter to the Youse site

  Scenario: Register a new user
    Given The user is on the youse site
    When The user goes to the registration page
    And Enters the user information
    And Submits the form
    Then The user should get a success registration message

  Scenario: Login a registered user
    Given The user is on the youse site
    When The user goes to the login page
    And Enters the credential
    Then The user should see a success login message

  Scenario: Logout a registered user
    Given The user is on the youse site
    And Is logged on the site
    When The user logs out
    Then The user should be on the home page

   Scenario Outline: Contact online a car insurance
     Given The user is on the youse site
     When The user selects contact online for car insurance
     And Enters the name "<name>"
     And Enters the phone "<phone>"
     And Enters the email "<email>"
     And Submits the information
     And Sets the car information
     Then The user selects the wanted plan
     And Selects additional insurance

   Examples:
     |name|phone|email|
     |Peter Parker|3001234567|test1@hotmail.com|
#     |Tony Stark  |3007894561|test2@hotmail.com|
#     |Bruce Wayne |3004561237|test3@hotmail.com|

