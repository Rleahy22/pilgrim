Pilgrim::Application.routes.draw do
  root :to => 'users#index'

  resources :users do
    resources :articles
  end

  get "/auth/google_oauth2/callback" => 'users#login'

  resources :words
  get '/test' => 'parsers#test'

  resources :articles
  get '/articles/grab/:id' => 'articles#grab'
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
end
