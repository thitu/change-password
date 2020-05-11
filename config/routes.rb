Rails.application.routes.draw do

    get '/', to: 'users#index'
   post '/', to: 'users#create'
  patch '/', to: 'users#update'

end
