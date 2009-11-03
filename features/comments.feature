In order to leave my opinion
As a user
I should be able to add comments

  Background:
    Given there is no posts
    And I've created "First!" post
    And I go to "First!" posts' page

  Scenario: Add comment
    When I fill in "Name" with "Bob"
    And I fill in "Body" with "My precious comment"
    And I press "Create Comment"
    Then I should see "Successfully created"
    And I should see "Bob"
    And I should see "My precious comment"

  @js
  Scenario: Add comment with ajax
    When I fill in "Name" with "Johnny"
    And I fill in "Body" with "Javascript comment"
    And I press "Create Comment"
    When I wait for the AJAX call to finish
    Then I should not see "Successfully created"
    And I should see "Johnny"
    And I should see "Javascript comment"
    And I should see "added with javascript"
