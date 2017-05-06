class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: [:update, :edit, :show]
  before_action :permission_user, only: [:show, :edit, :update]
  before_action :load_diagnoses, only: :show

  def show
    @title = t "users.information_user"
  end

  def edit
    @title = t "users.update"
  end

  def update
    user_update_params = current_user.admin? ? is_admin_user__params : user_params
    if @user.update_attributes user_update_params
      flash[:notice] = t "devise.registrations.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def set_params_search
    params[:q] ||= {}
    if params[:q][:created_at_lteq].present?
      params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day
    end
  end

  def is_admin_user__params
    params.require(:user).permit :name, :patient_code, :gender, :birthday, :avatar, :email,
      :password, :password_confirmation, :role
  end

  def user_params
    params.require(:user).permit :name, :patient_code, :gender, :birthday, :avatar, :email,
      :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = t "not_found_item"
    redirect_to :back
  end

  def load_diagnoses
    set_params_search
    if @user.admin? || @user.owner?
      @search = @user.active_diagnoses.ransack(params[:q])
    else
      @search = @user.passive_diagnoses.ransack(params[:q])
    end
    @diagnoses = @search.result.page(params[:page]).per Settings.per_page.admin.diagnose
  end
end
