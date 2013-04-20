Feature: Audio player
  In order to play a song and listen to the streamed music

  Scenario: Adding a song to the playlist
    Given I am logged in
    And I have no songs in my playlist
    When I add a song to the playlist
    Then I should have a song in my playlist

  Scenario: Appending a song to the playlist
    Given I am logged in
    And I have songs in my playlist
    When I add a song to the playlist
    Then the new song should be listed at the bottom

  Scenario: Playing a song
    Given I am logged in
    And I have a song in my playlist
    When I press play
    Then the song should be played