require 'resque/server'
Rails.application.routes.draw do
  post '/comment', to: 'commenters#create'
  root 'home#index'
  mount Resque::Server.new, :at => "/jobs"
end
