# frozen_string_literal: true

require('rails_helper')

RSpec.describe('PATCH requests', type: :request) do
  it 'will redirect to the index if CSRF validation fails' do
    allow_any_instance_of(ActionController::Base).to(receive(:protect_against_forgery?).and_return(true))

    patch '/'
    expect(response).to(redirect_to('/'))
    follow_redirect!

    expect(response).to(render_template(:index))
  end

  it 'responds with forbidden if session is *not* authorized' do
    patch '/', params: { id: 'user1@bob.com', pw_0: '12345678', pw_1: '12345678', intent: 'authorize' }
    expect(response).to(be_forbidden)
  end

  it 'responds with success if session is authorized' do
    post '/', params: { id: 'user1@bob.com', intent: 'authorize' }
    patch '/', params: { id: 'user1@bob.com', pw_0: '12345678', pw_1: '12345678', intent: 'authenticate' }
    expect(response).to(be_successful)
  end
end
