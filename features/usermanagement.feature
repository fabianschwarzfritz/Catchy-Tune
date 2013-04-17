Feature: User management
  In order to register and log in to the application

  Scenario: Log in successfully
    Given I am on the login page
    And I fill in "username" with "fabian@schwarz-fritz.de"
    And I fill in "password" with "password"
    When I press "Login"
    Then I am on the home page
    And I should be logged in

  Scenario: Log in unsuccessfully
    Given I am on the login page
    And I fill in "username" with "fabian@schwarz-fritz.de"
    And I fill in "password" with "awrongpassword"
    When I press "Login"
    Then I am on the login page
    And I should not be logged in


  Scenario: Register
    Given I am on the login page
    And I fill in "username" with "fabian@schwarz-fritz.de"
    And I fill in "password" with "password"
    And I fill in "passwordconfirmation" with "password"
    Then I am on the home page
    And I should be logged in
    And I should be registered

  Scenario: Register unsuccessfully
    Given I am on the login page
    And I fill in "username" with "fabian@schwarz-fritz.de"
    And I fill in "password" with "password"
    And I fill in "passwordconfirmation" with "passwordwrongspelled"
    Then I am on the login page
    And I should not be logged in
    And I should not be registered
