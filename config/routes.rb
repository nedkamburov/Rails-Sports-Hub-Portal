Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :admin do
    root :to => "pages#home"
    resources :articles

    resources :categories do
      resources :subcategories, only: [:create, :index]
      put :sort, on: :collection
    end

    resources :subcategories, except: [:create, :index] do
      resources :teams, only: [:create, :index]
      put :sort, on: :collection
    end

    resources :teams do
      put :sort, on: :collection
    end

    get "footer", to: "pages#footer"
    get "information-architecture", to: "pages#information_architecture"
  end

  # Defines the root path route ("/")
  root :to => "pages#home"
  resources :pages
end
