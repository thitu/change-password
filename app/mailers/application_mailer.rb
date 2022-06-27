# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_FROM')

  def notify(email)
    message = ENV.fetch('MAILER_MSG')
    message ||= 'Your password was changed'

    mail(to: email, subject: 'Password was successfully changed') do |format|
      format.text { render(plain: message) }
    end
  end
end
