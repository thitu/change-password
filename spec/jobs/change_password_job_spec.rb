# frozen_string_literal: true

require('rails_helper')

RSpec.describe(ChangePasswordJob, type: :job) do
  describe '#perform_later' do
    before { ActiveJob::Base.queue_adapter = :test }

    it 'queues up a job' do
      expect do
        ChangePasswordJob.perform_later('dummy@bob.com', 'password')
      end.to(have_enqueued_job)
    end
  end

  describe '#perform_now' do
    before { ActiveJob::Base.queue_adapter = :test }

    it 'raises an error if PASSWD_SH environment value is not set' do
      ENV['PASSWD_SH'] = nil

      expect do
        ChangePasswordJob.perform_now('dummy@bob.com', 'password')
      end.to(raise_error(StandardError))
    end

    it 'sends an email notification if the password change completes successfully' do
      ENV['PASSWD_SH'] = '/bin/echo'

      expect(ApplicationMailer).to(receive(:notify).with('dummy@bob.com').and_return(double.as_null_object))

      allow(double.as_null_object).to(receive(:deliver_now))

      ChangePasswordJob.perform_now('dummy@bob.com', 'password')
    end

    it 'does *not* send an email notification if the password change fails' do
      ENV['PASSWD_SH'] = 'false'

      expect(ApplicationMailer).not_to(receive(:notify).with('dummy@bob.com'))
      ChangePasswordJob.perform_now('dummy@bob.com', 'password')
    end
  end
end
