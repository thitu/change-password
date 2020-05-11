# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :init_user, only: %i[create update]
  before_action :authorize, only: :create
  before_action :authenticate, only: :update

  def index
    reset_session
  end

  def create
    return status(404) unless @authorized

    session[:email_address] = @user.email_address
    session[:authorized] = @authorized
    session[:id] = SecureRandom.uuid
  end

  def update
    @authorized = session[:authorized]
    return status(403) unless @authorized
  end

  private

  def authorize
    return unless @user.email_address.present?

    users = ENV[AUTHORIZED_USERS].squish.downcase.split(/[,\s]+/)

    @authorized = users.include?(@user.email_address)
  end

  def authenticate
    return unless session[:authorized] == true

    @auth_triggered = @user.authenticate
  end

  def init_user
    email_address = params[:id]&.squish&.downcase
    password_confirmation = params[:pw_1]&.squish
    password = params[:pw_0]&.squish

    @user = User.new({
                       password_confirmation: password_confirmation,
                       email_address: email_address,
                       intent: params[:intent],
                       password: password
                     })
  end
end
