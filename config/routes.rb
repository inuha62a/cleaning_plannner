Rails.application.routes.draw do
  # 管理者用ルート（namespace）
  namespace :admin do
    get "dashboard/index"
    # 今後追加するならここにまとめて書ける！
    # resources :users
    # resources :tasks
  end

  # 開発環境専用ルート（メール確認）
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  # ユーザー認証（Devise）
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  # 一般ユーザー向けルート
  root "static_pages#home"
  get "static_pages/terms"
  get "static_pages/privacy"
  get "static_pages/contact"
  get "users/profile" => "users#show", as: :users_profile

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA関連
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

end
