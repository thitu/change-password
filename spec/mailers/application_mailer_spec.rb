# frozen_string_literal: true

require('rails_helper')

RSpec.describe(ApplicationMailer, type: :mailer) do
  describe 'notify' do
    ENV['MAILER_MSG'] = 'your password was changed'
    let(:send_notification) { ApplicationMailer.notify('a@b.com') }

    it 'renders the headers' do
      notification = send_notification

      expect(notification.subject).to(eq('Password was successfully changed'))
      expect(notification.message.to_s).to(include(ENV['MAILER_MSG']))
      expect(notification.from).to(eq([ENV['MAILER_FROM']]))
      expect(notification.to).to(eq(['a@b.com']))
    end
  end
end
