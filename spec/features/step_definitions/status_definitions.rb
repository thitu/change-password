# frozen_string_literal: true

Then('I should have a response status of {int}') do |code|
  page.status_code.should eq(code)
end
