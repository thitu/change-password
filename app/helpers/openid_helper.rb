# frozen_string_literal: true

module OpenidHelper
  def openid_redirect_url(state:, nonce:)
    url = ENV.fetch('OIDC_AUTHORIZATION_ENDPOINT')
    redirect_uri = "#{root_url}openid/callback"

    url += "?redirect_uri=#{CGI.escape(redirect_uri)}"
    url += "&client_id=#{ENV.fetch('OIDC_CLIENT_ID')}"
    url += '&response_type=id_token'
    url += '&scope=openid+email'
    url += '&response_mode=code'
    url += "&nonce=#{nonce}"
    url += "&state=#{state}"

    url
  end
end
