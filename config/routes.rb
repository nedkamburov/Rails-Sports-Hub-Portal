Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}, controllers: {passwords: 'custom_devise/passwords', omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_scope :user do
    get "password/request_link_sent", to: "custom_devise/passwords#request_link_sent"
  end

  scope "(:locale)", locale: /en|bg/ do
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
        get :update_groupings, on: :collection

        member do
          get :toggle_status
        end
      end

      resources :photo_of_the_day

      resources :footer_pages, except: [:edit, :update] do
        get :filter_by_page_type, on: :collection

        member do
          put :toggle_status
        end
      end

      resources :users_panel, except: [:edit, :update] do
        get :filter_by_user_role, on: :collection

        member do
          patch :change_admin_status
          patch :change_lock_status
        end
      end

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
    resources :pages do
      get "global_search", on: :collection
    end
    resources :newsletters
  end
end
