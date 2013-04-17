Feature: Audio player
  In order to play a song and listen to the streamed music

  Scenario: Adding a song to the playlist
    Given I am logged in
    When I add a song to the playlist
    Then I should have a song in my playlist

  Scenario: Playing a song
    Given I am logged in
    And I have a song in my playlist
    When I play a song
    Then I the song should be played