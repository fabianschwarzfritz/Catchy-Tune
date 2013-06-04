Feature: Audio player
  In order to relax
  As a user
  I want to listen to music

  Background:
    Given a user "existinguser" with password "password"
    And I am logged in with user "existinguser" and password "password"
    And I am on the home page

  @javascript
  Scenario: Play a song
    Given there are these songs:
      | song_title | artist    | file                 |
      | a song     | an artist | exampledata/song.mp3 |
    And I fill in "Search" with "a song"
    And I press "search-submit"
    And I wait for 1 second
    And I click "Add"
    And I wait for 1 second
    When I click "play"
    Then "a song" should be played

  @javascript
  Scenario: Try to play a song with an empty playlist
    Given I have no songs in my playlist
    When I click "play"
    Then no song should be played

  @javascript
  Scenario: Play all songs of an artist
    Given there are these songs:
      | song_title | artist    | file                 |
      | a song     | an artist | exampledata/song.mp3 |
    And I fill in "Search" with "an artist"
    And I press "search-submit"
    And I wait for 1 second
    And I click "Add all"
    And I wait for 1 second
    When I click "play"
    Then "a song" should be played

  @javascript
  Scenario: Play several songs in a row
    Given there are these songs:
      | song_title   | artist         | file                  |
      | a song       | an artist      | exampledata/song.mp3  |
      | another song | another artist | exampledata/song2.mp3 |
    And I fill in "Search" with "a song"
    And I press "search-submit"
    And I wait for 1 second
    And I click "Add"
    And I fill in "Search" with "another song"
    And I press "search-submit"
    And I wait for 1 second
    And I click "Add"
    And I wait for 1 second
    When I click "next"
    And I wait for 1 second
    Then "another song" should be played
