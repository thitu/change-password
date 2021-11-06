# frozen_string_literal: true

module UsersHelper
  def authorized_users
    ENV[AUTHORIZED_USERS].squish.downcase.split(/[,\s]+/)
  end
end
