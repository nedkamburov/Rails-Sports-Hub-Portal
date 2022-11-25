Feature: Articles on the public side
  Scenario: Visit an article page as a guest user
    When I visit an article with this headline:
      | Headline | Amazing testing title |
    Then I should have an article with that headline:
      | Headline | Amazing testing title |
    Then I should not be able to see a comment form

  Scenario: Visit an article and leave a comment as logged-in user
    When I log in as a user with name:
      | Name | John Doe |
    Then I visit an article
    Then I should be able to see a comment form
    When I comment on the article with:
      | Content | What a wonderful piece! |
    And I sort the comments by 'Most recent'
    Then I should see at the top a comment with these attributes:
      | Content   | What a wonderful piece! |
      | User name | John Doe                |
