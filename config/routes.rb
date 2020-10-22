Rails.application.routes.draw do
  resources :tasks do
    collection do
      get 'sort'
      get 'filter'
      get 'search'
    end
  end
end
