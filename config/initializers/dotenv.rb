# frozen_string_literal: true
Dotenv.require_keys('OIDC_CLIENT_ID', 'TRUSONA_TOKEN', 'TRUSONA_SECRET', 'AUTHORIZED_USERS', 'PASSWD_SH', 'MAILER_FROM')

CURRENT_SALT = SecureRandom.alphanumeric(64)
