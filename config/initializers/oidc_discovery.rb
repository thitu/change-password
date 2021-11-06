# frozen_string_literal: true

return if Rails.env.test?

url = 'https://gateway.trusona.net/oidc/.well-known/openid-configuration'

response = JSON(HTTParty.get(url).body)
jwk_data = JSON(HTTParty.get(response['jwks_uri']).body)
certificate = Base64.decode64(jwk_data['keys'][0]['x5c'][0])

ENV['OIDC_AUTHORIZATION_ENDPOINT'] = response['authorization_endpoint']
OIDC_PUBLIC_KEY = OpenSSL::X509::Certificate.new(certificate).public_key
