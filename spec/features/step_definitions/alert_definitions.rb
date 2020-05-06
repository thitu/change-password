# frozen_string_literal: true

Then('I should be shown a {string} alert with the text {string}') do |type, value|
  css_class = ".alert-#{type}"

  page.should have_css('.alert')
  page.should have_css(css_class)

  within css_class do
    has_content?(value)
  end
end
