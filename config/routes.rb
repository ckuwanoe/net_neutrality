Rails.application.routes.draw do
  post '/comment', to: 'commenters#create'
  root 'home#index'
end
