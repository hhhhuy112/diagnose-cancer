class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout

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

  def layout
    if current_user.present?
      if current_user.admin?
        is_a?(Devise::RegistrationsController) ? "admin/layouts/admin" : false
      else
        is_a?(Devise::RegistrationsController) ? "application" : false
      end
    end
  end
end
