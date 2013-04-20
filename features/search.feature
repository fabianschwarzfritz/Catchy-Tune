Feature: Search
  In order to find songs on the platform

  Scenario: Search for a song by title
    Given I am on the search page
    And I fill in "search" with "Walk The Line"
    When I press "Search"
    Then I should be on the search result page
    And I should see "Walk The Line"

  Scenario: Search for a song by artist
    Given I am on the search page
    And I fill in "search" with "Jonny Cash"
    When I press "Search"
    Then I should be on the search result page
    And I should see "Walk The Line"

  Scenario: Search with only part of the information
    Given I am on the search page
    And I fill in "search" with "Walk"
    When I press "Search"
    Then I should be on the search result page
    And I should see "Walk The Line"

  Scenario: Search pattern's case is wrong
    Given I am on the search page
    And I fill in "search" with "jonny cash"
    When I press "Search"
    Then I should be on the search result page
    And I should see "Walk The Line"