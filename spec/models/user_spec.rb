# frozen_string_literal: true

require('rails_helper')

RSpec.describe(User, type: :model) do
  context '#authenticate' do
    before { ActiveJob::Base.queue_adapter = :test }

    it 'will queue up approval for a password change if the user is valid' do
      user = User.new({ email_address: 'a@b.com', password: '12345678', password_confirmation: '12345678' })

      user.update_credentials

      expect(ApprovePasswordChangeJob).to(have_been_enqueued)
      expect(ChangePasswordJob).to(have_been_enqueued.exactly(0))
    end

    it 'will *not* queue approval for a password change if the user is invalid' do
      user = User.new({ email_address: 'a@b.com', password: '123456789', password_confirmation: '12345678' })

      user.update_credentials

      expect(ApprovePasswordChangeJob).to(have_been_enqueued.exactly(0))
      expect(ChangePasswordJob).to(have_been_enqueued.exactly(0))
    end
  end

  context '#validate' do
    it 'is invalid if password is empty' do
      expect(User.new(email_address: 'bob@foo', password: nil)).to(be_invalid)
      expect(User.new(email_address: 'bob@foo', password: '')).to(be_invalid)
      expect(User.new(email_address: 'bob@foo', password: '     ')).to(be_invalid)
    end

    it 'is invalid if password is short' do
      expect(User.new(email_address: 'bob@foo', password: '1234567')).to(be_invalid)
    end

    it 'is valid if password is 8 characters' do
      hash = { email_address: 'a@b.co', password: '12345678', password_confirmation: '12345678' }
      expect(User.new(hash)).to(be_valid)
    end

    it 'is valid if password is more than 8 characters' do
      hash = { email_address: 'a@b.co', password: '123456789', password_confirmation: '123456789' }
      expect(User.new(hash)).to(be_valid)
    end

    it 'is valid if the password values match' do
      hash = { email_address: 'a@b.co', password: '123456789', password_confirmation: '123456789' }
      expect(User.new(hash)).to(be_valid)
    end

    it 'is invalid if the password values do not match' do
      hash = { email_address: 'a@b.co', password: '123456789', password_confirmation: '1234567890' }
      expect(User.new(hash)).to(be_invalid)
    end

    it 'is invalid if the password includes any part of the email address' do
      hash = { email_address: 'a@b.co', password: '12345a@b.co6789', password_confirmation: '12345a@b.co6789' }
      expect(User.new(hash)).to(be_invalid)
    end

    it 'is invalid if the email address includes any part of the password' do
      hash = { email_address: '12345678@b.co', password: '12345678', password_confirmation: '12345678' }
      expect(User.new(hash)).to(be_invalid)
    end
  end
end
