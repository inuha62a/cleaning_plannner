class ApplicationController < ActionController::Base
  # 最新バージョンのブラウザだけアクセスを許可する（表示崩れや不具合を防ぐ）
  # allow_browser versions: :modern　　# Rails8以降で使用可能
  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    # ユーザー登録時にnameのストロングパラメータを追加（サインアップ時にnameを入力する場合は追記）
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    # ユーザー編集時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :profile ])
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
