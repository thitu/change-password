# frozen_string_literal: true

class ChangePasswordJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ApplicationMailer.notify(args[0]).deliver_now
  end
end
