# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  def edit
    self.resource = resource_class.find_by_reset_password_token(params[:reset_password_token])

    if resource.nil? || resource.reset_password_period_valid? == false
      redirect_to new_user_password_path, alert: "このパスワード再設定リンクは期限切れです。もう一度再送してください。"
    else
      super
    end
  end
  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
