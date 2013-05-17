Feature: User management
  In order to be allowed to use the application
  As a potential user
  I want to register and log in


  Background:
    Given a user "existinguser" with password "password"
    And I am logged out



  Scenario: Sign up successfully
    When I sign up with user "fabian" and password "password"
    Then I should be on the home page
    And I should be logged in

  Scenario Outline: Try to sign up with wrong data
    When I sign up with user "<username>" and password "<password>" and password confirmation "<password confirmation>"
    Then I should be on the sign up page
    And I should see an error message
    And I should not be logged in

    Examples:
      | username      | password        | password confirmation | description         |
      | fabian        | password        | passwordspelledwrong  | wrong confirmation  |
      | existinguser  | password        | password              | existing user       |


  Scenario: Log in successfully
    When I log in with user "existinguser" and password "password"
    Then I should be on the home page
    And I should be logged in as "existinguser"

  Scenario Outline: Try to log in with wrong data
    When I log in with user "<username>" and password "<password>"
    Then I should be on the login page
    And I should see an error message
    And I should not be logged in

    Examples:
      | username      | password              | description         |
      | existinguser  | passwordspelledwrong  | wrong password      |
      | unknownuser   | password              | wrong username      |


  Scenario: Try to get in without logging in
    Given I am logged out
    When I visit the home page
    Then I should be on the login page

