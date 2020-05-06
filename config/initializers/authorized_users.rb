# frozen_string_literal: true

AUTHORIZED_USERS = 'AUTHORIZED_USERS'
raise 'Missing Authorized Users environment variable' if ENV[AUTHORIZED_USERS].nil?
