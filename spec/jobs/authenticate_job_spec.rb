# frozen_string_literal: true

require('rails_helper')

RSpec.describe(AuthenticateJob, type: :job) do
  describe '#perform_later' do
    before { ActiveJob::Base.queue_adapter = :test }

    it 'queues up a job' do
      expect do
        AuthenticateJob.perform_later('dummy@bob.com', 'password')
      end.to(have_enqueued_job)
    end
  end

  describe '#perform' do
    before { ActiveJob::Base.queue_adapter = :test }

    it 'will create a trusonafication' do
      expect(Trusona::EssentialTrusonafication).to(receive(:create).with(any_args))

      AuthenticateJob.perform_now('dummy@bob.com', 'password')
    end

    it 'will trigger a password change job if authentication is accepted' do
      allow(Trusona::EssentialTrusonafication)
        .to(receive(:create).with(any_args))
        .and_yield(Trusona::Resources::Trusonafication.new)

      allow_any_instance_of(Trusona::Resources::Trusonafication)
        .to(receive(:accepted?))
        .and_return(true)

      AuthenticateJob.perform_now('dummy@bob.com', 'password')

      expect(ChangePasswordJob).to(have_been_enqueued)
    end

    it 'will *not* trigger a password change job if authentication is not accepted' do
      allow(Trusona::EssentialTrusonafication)
        .to(receive(:create).with(any_args))
        .and_yield(Trusona::Resources::Trusonafication.new)

      allow_any_instance_of(Trusona::Resources::Trusonafication)
        .to(receive(:accepted?))
        .and_return(false)

      AuthenticateJob.perform_now('dummy@bob.com', 'password')

      expect(ChangePasswordJob).to(have_been_enqueued.exactly(0))
    end
  end
end
