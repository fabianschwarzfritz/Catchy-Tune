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

  Scenario: Play a song
    Given I have "a song" in my playlist
    When I press "play"
    Then a song should be played
