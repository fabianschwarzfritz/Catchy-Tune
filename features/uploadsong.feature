Feature: Upload song
  In order to spread my music
  As an artist
  I want to upload my new songs

  Background:
    Given a user "John Doe" with password "password"

  Scenario: Normal users are requested to register an artist name
    Given I am logged in with user "John Doe" and password "password"
    And I am on the home page
    When I click "Upload"
    Then I should be on the register-artist page

  Scenario: Register an artist name
    Given I am logged in with user "John Doe" and password "password"
    And I am on the register-artist page
    When I fill in "Name" with "Johnny"
    And I press "Create"
    Then I should be on the new-track page

  Scenario: Artists can proceed to upload a track directly
    Given an artist "Mozart" with user "mozart" and password "password"
    And I am logged in with user "mozart" and password "password"
    And I am on the home page
    When I click "Upload"
    Then I should be on the new-track page

  Scenario: Upload a track
    Given an artist "Mozart" with user "mozart" and password "password"
    And I am logged in with user "mozart" and password "password"
    And I am on the new-track page
    When I fill in "Title" with "A new title"
    And I select the file "/exampledata/song.mp3" for "file"
    And I press "Create"
    Then I should be on the song detail page
    And I should see "A new title"
