# frozen_string_literal: true

SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true,
    httponly: true,
  }
  config.csp = {
    default_src: %w(https: 'self' 'unsafe-inline'),
    script_src: %w(https: 'unsafe-inline' 'self'),
  }
end
