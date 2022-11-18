Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}, controllers: {passwords: 'custom_devise/passwords', omniauth_callbacks: 'users/omniauth_callbacks'}

  devise_scope :user do
    get "password/request_link_sent", to: "custom_devise/passwords#request_link_sent"
    # get 'profile/edit'    => 'devise/registrations#edit',   :as => :edit_user_registration
    # get 'profile/cancel'  => 'devise/registrations#cancel', :as => :cancel_user_registration
  end

  namespace :admin do
    root :to => "pages#home"

    resources :categories do
      resources :subcategories, only: [:index, :create]
      put :sort, on: :collection
    end

    resources :subcategories, except: [:index, :create] do
      resources :teams, only: [:index, :create]
      put :sort, on: :collection
    end

    resources :teams do
      put :sort, on: :collection
    end

    resources :articles do
      put :sort, on: :collection
      member do
        get :toggle_status
      end
    end

    get "footer", to: "pages#footer"
    get "information-architecture", to: "pages#information_architecture"
  end

  # Defines the root path route ("/")
  root :to => "pages#home"

  resources :articles, only: [:index, :show] do
    member do
      post :show
    end
    resources :comments
  end

  resources :likes, :dislikes, only: [:create, :destroy]
  resources :pages
  resources :newsletters
end
