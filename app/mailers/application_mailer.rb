# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'changed-password@cp.nmcode.net'

  def notify(email)
    mail(to: email, subject: 'Password was successfully changed') do |format|
      format.text { render plain: 'Message from: https://cp.nmcode.net' }
    end
  end
end
