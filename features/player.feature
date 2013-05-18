Feature: Audio player
  In order to relax
  As a user
  I want to listen to music

  Background:
    Given a user "existinguser" with password "password"
    And I am logged in with user "existinguser" and password "password"

  Scenario: Add a song to the playlist
    Given I have no songs in my playlist
    When I add a song to the playlist
    Then I should have a song in my playlist

  Scenario: Appending a song to the playlist
    Given I have a song in my playlist
    When I add a song to the playlist
    Then the new song should be played as the last song

  Scenario: Playing a song
    Given I have a song in my playlist
    When I press "play"
    Then a song should be played
