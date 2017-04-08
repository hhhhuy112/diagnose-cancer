class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :gender,:birthday, :password, :password_confirmation, :avatar)
    end
  end

  def after_sign_in_path_for _resource
    if current_user.admin?
      admin_data_cancers_path
    end
  end
end
