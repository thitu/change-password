# frozen_string_literal: true

require('rails_helper')

RSpec.describe('POST requests', type: :request) do
  it 'will redirect to the index if CSRF validation fails' do
    allow_any_instance_of(ActionController::Base).to(receive(:protect_against_forgery?).and_return(true))

    post '/'
    expect(response).to(redirect_to('/'))
    follow_redirect!

    expect(response).to(render_template(:index))
  end

  context 'if specified user is not authorized' do
    it 'responds with not found' do
      post '/', params: { id: 'user0@bob.com', intent: 'authorize' }
      expect(response).to(be_not_found)
    end
  end

  context 'if specified user is authorized' do
    it 'redirects to the OIDC endpoint' do
      post '/', params: { id: 'user1@bob.com', intent: 'authorize' }
      expect(response.status).to(be(302))
      expect(response.location).to(start_with("#{ENV.fetch('OIDC_AUTHORIZATION_ENDPOINT')}?"))
    end
  end
end
