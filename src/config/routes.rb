Rails.application.routes.draw do
  # ユーザー関連
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks',
    #omniauth_callbacks: "users/omniauth_callbacks"
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  # 商品
  resources :products, only: [:index, :show] do
    member do
      # カートに追加
      post :add
    end
  end

  # カート
  resources :cart, only: [:index, :destroy]

  # 開発者向けページ
  get "development/index"

  # 管理画面
  scope "/admin_secret" do
    devise_for :admin_users, controllers: {
      sessions: 'admin/admin_users/sessions',
      passwords: 'admin/admin_users/passwords',
    }

    scope as: "admin", module: "admin" do
      get "", to: "home#index"
      resources :users, except: [:show] do
        member do
          patch :restore
        end
      end
      resources :products, except: [:show] do
        member do
          patch :restore
        end
      end
    end
  end
end
