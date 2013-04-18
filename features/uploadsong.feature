Feature: Upload song
  In order to upload a song to a platform

  Scenario: Upload a song
    Given I am on the search page
    And I am logged in as artist
    When I press "Upload"
    And I fill in "title" with "A new title"
    And I upload a file
    And I press "Upload"
    Then I should be on the search page

    When I fill in "search" with "A new title"
    And I press "Search"
    Then I should see "A new title"
