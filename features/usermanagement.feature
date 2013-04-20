Feature: User management
  In order to register and log in to the application

  Scenario: Register successfully
    Given I am on the login page
    And I fill in "username" with "fabian@schwarz-fritz.de"
    And I fill in "password" with "password"
    And I fill in "passwordconfirmation" with "password"
    When I press "Register"
    Then I should be on the home page
    And I should be logged in
    And I should be registered

  Scenario: Password spelled wrong
    Given I am on the login page
    And I fill in "username" with "fabian@schwarz-fritz.de"
    And I fill in "password" with "password"
    And I fill in "passwordconfirmation" with "passwordspelledwrong"
    When I press "Register"
    Then I should be on the login page
    And I should not be logged in
    And I should not be registered

  Scenario: User already exists
    Given I am on the login page
    And a user "existinguser" exists
    And I fill in "username" with "existinguser"
    And I fill in "password" with "password"
    And I fill in "passwordconfirmation" with "password"
    When I press "Register"
    Then I should see an error message
    And I should not be logged in


  Scenario: Log in successfully
    Given I am on the login page
    And I fill in "username" with "fabian@schwarz-fritz.de"
    And I fill in "password" with "password"
    When I press "Login"
    Then I should be on the home page
    And I should be logged in as "fabian@schwarz-fritz.de"

  Scenario: Log in with a wrong password
    Given I am on the login page
    And I fill in "username" with "fabian@schwarz-fritz.de"
    And I fill in "password" with "awrongpassword"
    When I press "Login"
    Then I should be on the login page
    And I should not be logged in

  Scenario: Log in with a not-existent user
    Given I am on the login page
    And a user "not-existent user" does not exist
    And I fill in "username" with "not-existent user"
    And I fill in "password" with "password"
    When I press "Login"
    Then I should be on the login page
    And I should not be logged in
