# frozen_string_literal: true

class ApprovePasswordChangeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    params = {
      action: 'request',
      resource: 'change your password',
      email: args[0],
      expires_at: (Time.now + 45.seconds).utc.iso8601
    }

    Trusona::EssentialTrusonafication.create(params: params) do |trusonafication|
      ChangePasswordJob.perform_later(args[0], args[1]) if trusonafication.accepted?
    end
  end
end
