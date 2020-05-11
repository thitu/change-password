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

  it 'respond with not found if specified id is not authorized' do
    post '/', params: { id: 'bob@bob.com' }
    expect(response).to(be_not_found)
  end

  it 'respond with success if specified id is authorized' do
    post '/', params: { id: 'user1@bob.com' }
    expect(response).to(be_successful)
  end
end
