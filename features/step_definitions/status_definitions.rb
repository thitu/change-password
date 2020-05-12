# frozen_string_literal: true

Then('I should have a response status of {int}') do |code|
  expect(page.status_code).to(eq(code))
end
