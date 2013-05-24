Feature: Upload song
  In order to spread my music
  As an artist
  I want to upload my new songs

  Background:
    Given an artist "Mozart" with user "mozart" and password "password"
    And a user "John Doe" with password "password"

  Scenario: Upload a song
    Given I am logged in with user "Mozart" and password "password"
    And I am on the home page
    When I press "Upload"
    And I fill in "title" with "A new title"
    And I select the file "/exampledata/song.mp3" for "file"
    And I press "Upload"
    Then I should be on the song detail page
    And I should see "A new title"

  Scenario: Upload as a normal user
    Given I am logged in with user "John Doe" and password "password"
    And I am on the search page
    Then I should not see "Upload"
