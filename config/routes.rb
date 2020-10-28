Rails.application.routes.draw do
  get 'hello_vue/index'
  resources :tasks do
    collection do
      get 'sort'
      get 'filter'
      get 'search'
    end
  end
end
