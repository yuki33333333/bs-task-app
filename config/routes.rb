Rails.application.routes.draw do
  get 'hello_vue/index'

  resources :users, only: [:new, :create]
  namespace :users do
    get '/login' => 'sessions#new'
    post '/login' => 'sessions#create'
    delete '/login' => 'sessions#destroy'
  end

  resources :tasks do
    collection do
      get 'sort'
      get 'filter'
      get 'search'
    end
  end

  get 'admins/top' => 'admins#top'
  namespace :admins do
    get '/login' => 'sessions#new'
    post '/login' => 'sessions#create'
    delete '/login' => 'sessions#destroy'
  end
end
