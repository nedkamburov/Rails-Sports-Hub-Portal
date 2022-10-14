Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :admin do
    root :to => "pages#home"
    resources :pages
    get "footer", to: "pages#footer"
  end

  # Defines the root path route ("/")
  root :to => "pages#home"
  resources :pages
end
