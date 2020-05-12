Feature: Home Page Visit
  Scenario: Visiting the home page
    When I visit the home page
    Then I should have a successful response
    Then I should see a text input with a 'placeholder' property value of 'Email Address'
    Then I should see a text input with a 'name' property value of 'id'
    Then I should see a text input with a 'id' property value of 'id'
    Then I should see a 'intent' button with a value of 'authorize'

  Scenario: Visiting the home page - and I submit without providing input
    When I visit the home page
    And I do not provide any text input
    And I click on the 'authorize' button
    Then I should have a response status of 404
