Feature: create and delete movie and search movie by director

  As a movie buff
  So that I can find movies with my favorite director
  I want to include and search on director information in movies I enter

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
  | Hey There    | G      | Ridley Scott |   1971-03-11 |
  | abcde        | R      |              |   1979-05-25 |
  | fghij        | R      | La Ta        |   1979-05-25 |
  
  
Scenario: find movie with same director again
  Given I am on the details page for "Hey There"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "Hey There"
  And   I should see "Blade Runner"
  And   I should see "Ridley Scott"
  But   I should not see "THX-1138"
  And   I should not see "Star Wars"
  And   I should not see "George Lucas"

Scenario: find movie with same director solo
  Given I am on the details page for "fghij"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "fghij"
  And   I should not see "Blade Runner"
  And   I should not see "Ridley Scott"
  And   I should not see "THX-1138"
  And   I should not see "Star Wars"
  And   I should not see "Alien"
  And   I should not see "abcde"
  And   I should not see "Hey There"


Scenario: can't find similar movies if we don't know director again (sad path)
  Given I am on the details page for "abcde"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the home page
  And   I should see "'abcde' has no director info"

Scenario: create a new movie
  Given I am on the home page
  When  I follow "Add new movie"
  Then  I should be on the Create New Movie page
  And   I fill in "Title" with "Movie A"
  And   I fill in "Director" with "Director B"
  When  I press "Save Changes"
  Then  I should be on the home page
  And   I should see "Movie A was successfully created."
  And   I should see "Movie A"
  And   the director of "Movie A" should be "Director B"

Scenario: destroy a new movie
  Given I am on the details page for "Star Wars"
  When  I follow "Delete"
  Then  I should be on the home page
  And   I should see "Movie 'Star Wars' deleted."
  
Scenario: edit by adding director to existing movie
  When I go to the edit page for "abcde"
  And  I fill in "Director" with "Ridley Scott"
  And  I press "Update Movie Info"
  Then I should see "abcde was successfully updated."
  Then the director of "abcde" should be "Ridley Scott"
