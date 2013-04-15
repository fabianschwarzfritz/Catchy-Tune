Feature: Search
  In order to find songs on the platform

  Scenario: Search for a song by artist
    Given I am on the search page
    And I fill in "search" with "Jonny Cash"
    When I press "Search"
    Then I should see "Walk The Line"