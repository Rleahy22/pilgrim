Pilgrim::Application.routes.draw do
  root :to => 'users#index'

  resources :users

  get "/auth/google_oauth2/callback" => 'users#login'

  resources :words
  get '/test' => 'parsers#test'

  resources :articles

  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
end
