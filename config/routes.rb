Pilgrim::Application.routes.draw do
  root :to => 'users#index'

  resources :users do
    resources :articles
  end

  get "/auth/google_oauth2/callback" => 'users#login'
  get "/users/:id/logout" => 'users#logout', as: "user_logout"

  resources :articles
  post '/articles/grab' => 'articles#grab'
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)

end
