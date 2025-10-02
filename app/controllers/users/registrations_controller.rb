class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [ :update ]

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # パスワードが空なら、パスワード関連のキーを削除して更新
    if account_update_params[:password].blank? && account_update_params[:password_confirmation].blank?
      account_update_params.delete(:password)
      account_update_params.delete(:password_confirmation)
      account_update_params.delete(:current_password)

      if resource.update(account_update_params)
        bypass_sign_in(resource)
        redirect_to users_profile_path, notice: "プロフィールを更新しました。"
      else
        render :edit
      end
    else
      # 通常の Devise の更新処理（パスワード変更あり）
      super
    end
  end

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :email, :password, :password_confirmation, :current_password ])
  end
end
