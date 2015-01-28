Rails.application.routes.draw do
  root 'top#index'
  post '/' => 'top#tag'
end
