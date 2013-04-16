Feature: Search
  In order to find songs on the platform

  Scenario: Search for a song by artist
    Given I am on the search page
    And I fill in "search" with "Jonny Cash"
    When I press "Search"
    Then I should see "Walk The Line"

  Scenario: Log in
    Given I am on the login page
    And I fill in "username" with "fabian@schwarz-fritz.de"
    When I press "Login"
    Then I should see the home page