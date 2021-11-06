Rails.application.routes.draw do
  root :to => 'users#index'

    get '/', to: 'users#index'
   post '/', to: 'users#create'
  patch '/', to: 'users#update'

  post '/openid/callback', to: 'users#callback'

  get '/openid/callback/:state/:nonce', to: 'users#process_callback'

  match '*path' => redirect('/'), via: [:get, :post]

end
