class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: [:update, :edit, :show]

  def show
    @title = t "users.information_user"
  end

  def edit
    @title = t "users.update"
  end

  def update
    if @user.update_attributes user_params
      flash[:notice] = t "devise.registrations.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :patient_code, :gender, :birthday, :avatar, :email,
      :password, :password_confirmation, :role
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = t "not_found_item"
    redirect_to :back
  end
end
