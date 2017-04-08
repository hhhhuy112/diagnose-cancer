class UsersController < ApplicationController
  def new
  end

  def create
  end

  private

  def user_params
    params.require(:user).permit :name, :gender, :birthday, :avatar, :email,
      :password, :password_confirmation, :role
  end
end
