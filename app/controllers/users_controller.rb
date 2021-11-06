# frozen_string_literal: true

class UsersController < ApplicationController
  include HashingHelper
  include OpenidHelper
  include UsersHelper

  skip_before_action :verify_authenticity_token, only: :callback

  before_action :callback_params, only: :callback
  before_action :create_params, only: :create
  before_action :update_params, only: :update

  before_action :normalize_inputs, only: %i[create update]
  before_action :authorize, only: :create
  before_action :init_user, only: :update

  def index
    reset_session
    reset_cookies
  end

  def create
    error_status(404)
  end

  def update
    return error_status(403) unless valid_state

    @authorized = true
    @update_triggered = @user.update_credentials
  end

  def callback
    return error_status(404) unless authorized_users.include?(payload['sub'])

    checksum = checksum([current_salt, params[:state], payload['nonce'], payload['sub']])
    redirect_to("/openid/callback/#{params[:state]}/#{payload['nonce']}/#{checksum}")
  end

  def process_callback
    return error_status(403) unless valid_state

    @user = User.new(email_address: cookies[:email_address])
    @authorized = true
    render('update')
  end

  private

  def valid_state
    computed_checksum = checksum([current_salt, cookies[:state], cookies[:nonce], cookies[:email_address]])
    stored_checksum = params[:checksum].presence || cookies[:checksum]

    cookies[:state].present? && cookies[:nonce].present? && computed_checksum == stored_checksum
  end

  def payload
    @payload = JWT.decode(params[:id_token], OIDC_PUBLIC_KEY, true, algorithm: 'RS256')[0]
  rescue StandardError
    redirect_to_root
  end

  def callback_params
    params.permit(:token_type, :id_token, :state)
  end

  def create_params
    params.permit(:id, :intent, :authenticity_token)
  end

  def update_params
    params.permit(:id, :password, :password_confirmation, :intent, :authenticity_token)
  end

  def authorize
    return error_status(404) unless authorized_users.include?(@email_address)

    cookies[:nonce] = nonce = SecureRandom.alphanumeric(16)
    cookies[:state] = state = SecureRandom.uuid
    cookies[:email_address] = @email_address
    cookies[:checksum] = checksum([current_salt, state, nonce, @email_address])

    redirect_to(openid_redirect_url(state: state, nonce: nonce))
  end

  def normalize_inputs
    @email_address = cookies[:email_address].presence || params[:id]&.squish&.downcase
    @intent = params[:intent]

    @password_confirmation = params[:password_confirmation]&.squish
    @password = params[:password]&.squish
  end

  def init_user
    return error_status(404) unless authorized_users.include?(@email_address)

    @user = User.new(
      password_confirmation: @password_confirmation,
      email_address: @email_address,
      password: @password
    )
  end
end
