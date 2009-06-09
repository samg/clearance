Feature: Sign up
  In order to give someone access to the site
  A logged in user
  Should be able to sign up another user

    Scenario: User is not logged in
      When I go to the sign up page
      Then I should see "Sign in"

    Scenario: User signs up with invalid data
      Given I am signed in as "admin@person.com"
      When I go to the sign up page
      And I fill in "Email" with "invalidemail"
      And I press "Create"
      Then I should see error messages

    Scenario: User signs up with valid data
      Given I am signed in as "admin@person.com"
      When I go to the sign up page
      And I fill in "Email" with "email@person.com"
      And I press "Create"
      Then I should see "instructions for confirming"
      And a confirmation message should be sent to "email@person.com"

    Scenario: User confirms his account and sets password
      Given I was signed up as "email@person.com"
      When I follow the password reset link sent to "email@person.com"
      And I update my password with "newpassword/newpassword"
      And I should be signed in

