Feature: Upload song
  In order to upload a song to a platform

  Scenario: Upload a song
    Given I am on the search page
    And I am logged in as an artist
    When I press "Upload"
    And I fill in "title" with "A new title"
    And I select a file
    And I press "Upload"
    Then I should be on the song detail page
    And the "title" field should contain "A new title"

  Scenario: Upload as a normal user
    Given I am on the search page
    And I am logged in as a normal user
    Then I should not see "Upload"
