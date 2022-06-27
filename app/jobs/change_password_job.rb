# frozen_string_literal: true

class ChangePasswordJob < ApplicationJob
  queue_as :default

  def perform(*args)
    raise(StandardError, 'Missing PASSWD_SH from ENV') unless ENV['PASSWD_SH'].present?

    result = system("#{ENV.fetch('PASSWD_SH')} #{args[0]} #{args[1]} > /dev/null")
    ApplicationMailer.notify(args[0]).deliver_now if result == true
  end
end
