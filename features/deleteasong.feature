Feature: Delete a song
  In order to delete a song

  Scenario: Delete a song
    Given I am on the detail page of the song "Walk the line"
    And I am logged in as artist
    And I am the artist of the song "Walk the line"
    When I press "Delete"
    Then I am on the search page

    Given I am on the search page
    And I fill in "search" with "Jonny Cash"
    When I press "Search"
    Then I should not see "Walk The Line"

