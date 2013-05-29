Feature: Audio player
  In order to relax
  As a user
  I want to listen to music

  Background:
    Given a user "existinguser" with password "password"
    And I am logged in with user "existinguser" and password "password"
    And I am on the home page

  Scenario: Add a song to the playlist
    Given I have no songs in my playlist
    When I add "a song" to my playlist
    Then I should have a song in my playlist

  Scenario: Append a song to the playlist
    Given I have "a song" in my playlist
    When I add "another song" to my playlist
    Then the song "another song" should be the last song in my playlist

  @javascript
  Scenario: Play a song
    Given there are these songs:
      | song_title | artist    | file                 |
      | a song     | an artist | exampledata/song.mp3 |
    And I fill in "Search" with "a song"
    And I press "search-submit"
    And I click "Add"
    When I click "play"
    Then "a song" should be played

  @javascript
  Scenario: Try to play a song with an empty playlist
    Given I have no songs in my playlist
    And I click "play"
    Then no song should be played

  @javascript
  Scenario: Play all songs of an artist
    Given there are these songs:
      | song_title | artist    | file                 |
      | a song     | an artist | exampledata/song.mp3 |
    And I fill in "Search" with "an artist"
    And I press "search-submit"
    And I click "Add all"
    When I click "play"
    Then "a song" should be played
