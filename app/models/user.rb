# frozen_string_literal: true

class User
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_reader :email_address

  validate :short_password
  validate :invalid_password
  validate :matching_passwords

  def initialize(email_address:, password: nil, password_confirmation: nil)
    @password_confirmation = password_confirmation
    @email_address = email_address
    @password = password
  end

  def update_credentials
    return unless valid?

    ApprovePasswordChangeJob.perform_later(@email_address, @password)
    true
  end

  private

  def short_password
    return unless errors.empty?

    errors.add(:base, SHORT_PASSWORD_ERROR) if @password.nil? || @password.length < PASSWORD_LENGTH
  end

  def invalid_password
    return unless errors.empty?

    errors.add(:base, INVALID_PASSWORD_ERROR) if @password.downcase == @email_address
    errors.add(:base, INVALID_PASSWORD_ERROR) if @password.include?(@email_address)
    errors.add(:base, INVALID_PASSWORD_ERROR) if @email_address.include?(@password)
  end

  def matching_passwords
    return unless errors.empty?

    matched = @password == @password_confirmation
    errors.add(:base, MISMATCHED_PASSWORDS_ERROR) unless matched
  end
end
