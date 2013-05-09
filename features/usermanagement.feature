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

  Scenario: Try to sign up with wrong password confirmation
    Given I am on the sign up page
    And I fill in "user_username" with "fabian"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "passwordspelledwrong"
    When I press "Sign up"
    Then I should be on the sign up page
    And I should see an error message
    And I should not be logged in




  Scenario: Try to sign up a user which already exists
    Given I am on the sign up page
    And user "existinguser" exists
    And I fill in "user_username" with "existinguser"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    When I press "Sign up"
    Then I should be on the sign up page
    And I should see an error message
    And I should not be logged in


  Scenario: Log in successfully
    Given I am on the login page
    And I fill in "login_username" with "existinguser"
    And I fill in "login_password" with "password"
    When I press "Log in"
    Then I should be on the home page
    And I should be logged in as "fabian"

  Scenario: Try to log in with a wrong password
    Given I am on the login page
    And I fill in "login_username" with "existinguser"
    And I fill in "login_password" with "passwordspelledwrong"
    When I press "Log in"
    Then I should be on the login page
    And I should not be logged in

  Scenario: Try to log in with a not-existent user
    Given I am on the login page
    And I fill in "login_username" with "not-existent user"
    And I fill in "login_password" with "password"
    When I press "Log in"
    Then I should be on the login page
    And I should not be logged in
