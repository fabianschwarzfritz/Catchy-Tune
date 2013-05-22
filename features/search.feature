Feature: Search
  In order to find the best songs
  As a user
  I want to search for songs

  Background:
    Given a user "user" with password "password"
    And I am logged in with user "user" and password "password"
    Given there are these songs:
      | song_title    | artist      |
      | Walk the Line | Jonny Cash  |
    And I am on the home page

  Scenario Outline: Searching
    When I fill in "Search" with "<query>"
    And I press "search-submit"
    Then I should be on the search result page
    And I should see "<expected_result>"

  Examples:
    | query         | expected_result | description                         |
    | Walk the Line | Walk the Line   | exact song title                    |
    | Jonny Cash    | Walk the Line   | exact artist name (returns title)   |
    | Jonny Cash    | Jonny Cash      | exact artist name (returns artist)  |
    | walk The line | Walk the Line   | song title in wrong case            |
    | jOnny cASh    | Walk the Line   | artist name in wrong case           |
    | walk          | Walk the Line   | only partial information            |
    | line          | Walk the Line   | only partial information            |
