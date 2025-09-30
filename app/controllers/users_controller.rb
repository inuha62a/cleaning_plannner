class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def require_admin
    redirect_to root_path, alert: "アクセス権限がありません" unless current_user.admin?
  end
  
  def show
    @user = current_user
  end
end
