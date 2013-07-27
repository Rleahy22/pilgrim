Pilgrim::Application.routes.draw do
  resources :words
  root :to => 'words#index'
  get '/test' => 'parsers#test'
end
