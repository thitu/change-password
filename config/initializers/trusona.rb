# frozen_string_literal: true

Trusona.config do |c|
  c.secret = ENV['TRUSONA_SECRET']
  c.token  = ENV['TRUSONA_TOKEN']
end
