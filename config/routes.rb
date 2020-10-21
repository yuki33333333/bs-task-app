Rails.application.routes.draw do
  resources :tasks do
    get 'sort', on: :collection
  end
end
