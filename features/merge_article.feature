Feature: Merge Articles
    As a blog administrator
    So that I can merge similar articles together
    I want to be able to merge artilces

    Background:
        Given the blog is set up
        Given these following users exist
            |profile_id     |name       |login      |password       |email                  |state      |
            |2              |user_2     |user_2     |123456         |user_2@gmail.com       |active     |
            |4              |user_4     |user_4     |654321         |user_4@gmail.com       |active     |
        Given these following articles exist
            |id             |title      |author     |user_id        |body       |allow_comments     |published      |published_at       |state      |type   |
            |3              |Hello world|user_2     |2              |Hello      |true               |true           |12-Oct-2012        |published  |Article|
            |4              |Hi world   |user_4     |4              |Hi         |true               |true           |16-Oct-2012        |published  |Article|
        Given these following comments exist
            |id             |type           |author         |body       |article_id     |user_id        |created_at |
            |1              |Comment        |user_4         |good       |3              |4              |17-Oct-2012|
            |2              |Comment        |user_2         |nice       |4              |2              |18-Oct-2012|

    Scenario: non-admin cannot merge articles
        Given I am logged in as "user_2" with password "123456"
        When I am on the "Hello world" edit page
        Then I should not see "Merge"
    
    Scenario: Only admin can merge articles
        Given I am logged into the admin panel
        When I am on the "Hello world" edit page
        Then I should see "Merge"
        When I fill in "merge_with" with "4"
        Then I press "Merge"
        Then I should be on the "Hello world" edit page
        And I should see "Successfully merged"

    Scenario: When articles are merged, the merged article should contain the text of both previous Articles
        Given "Hello world" is merged with "Hi world"
        When I am on the home page
        When I follow "Hello world"
        Then I should see "Hello"
	And I should see "Hi"
  
    Scenario: When articles are merged, the merged article should have one author (either one of the authors of the original article)
        Given "Hello world" is merged with "Hi world"
        Then "user_2" has 1 article
        And "user_4" has 0 article

    Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article
        Given "Hello world" is merged with "Hi world"
        When I am on the home page
        When I follow "Hello world"
        Then I should see "good"
        And I should see "nice"
    
    Scenario: The title of the new article should be the title from either of the merged articles.
        Given "Hello world" is merged with "Hi world"
        When I am on the home page
        Then I should see "Hello world"
        And I should not see "Hi world"


