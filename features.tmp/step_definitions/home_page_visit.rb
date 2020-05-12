# frozen_string_literal: true

When('I visit the home page') do
  visit '/'
end

When('I click on the {string} button') do |value|
  within '.form_div' do
    click_button(value)
  end
end

Then('I should have a successful response') do
  expect(page.status_code).to(eq(200))
end

Then('I should see a text input with a {string} property value of {string}') do |key, value|
  expect(page).to(have_selector("input[type='text']"))
  expect(page).to(have_selector("input[#{key}='#{value}']"))
end

Then('I should see a {string} button with a value of {string}') do |intent, string|
  expect(page).to(have_selector("input[type='submit']"))
  expect(page).to(have_selector("input[name='#{intent}']"))
  expect(page).to(have_selector("input[value='#{string}']"))
end

When('I do not provide any text input') do
end
