Rails.application.routes.draw do
  get 'hello_vue/index'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :tasks do
    collection do
      get 'sort'
      get 'filter'
      get 'search'
    end
  end
  resources :admins, only: [:show]
end
