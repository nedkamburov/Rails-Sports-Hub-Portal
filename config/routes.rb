Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :admin do
    root :to => "pages#home"
    resources :pages do
      put :sort, on: :collection
    end
    get "footer", to: "pages#footer"
    get "information-architecture", to: "pages#information_architecture"

  end

  # Defines the root path route ("/")
  root :to => "pages#home"
  resources :pages

  get "pages/:id", to: "pages#show"
end
