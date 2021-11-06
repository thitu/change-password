source .env.local

clear
bundle exec rails s -b "ssl://localhost:3000?key=$SSL_KEY&cert=$SSL_CERT"