class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout
  before_action :set_title_edit_password

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :gender,:birthday, :password, :password_confirmation, :avatar)
    end
  end

  def after_sign_in_path_for _resource
    if current_user.admin?
      admin_data_cancers_path
    else
      user_path(current_user)
    end
  end

  def logged_in_user
    unless user_signed_in?
      flash[:danger] = t "please_log_in"
      redirect_to root_path
    end
  end

  def authenticate_admin!
    return if current_user.admin?
    flash[:alert] = t "you_do_not_have_access"
    redirect_to root_path
  end

  def set_title_edit_password
     if is_a?(Devise::RegistrationsController)
      @title = t "users.update_password"
    end
  end

  def layout
    if current_user.present?
      if current_user.admin?
        "admin/layouts/admin"
      else
        "application"
      end
    end
  end
end
