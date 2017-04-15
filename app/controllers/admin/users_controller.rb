class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: :destroy
  def index
    @search = User.ransack(params[:q])
    @users = @search.result
    @users = @users.page(params[:page]).per Settings.per_page.admin.user
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "devise.registrations.signed_up"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "devise.registrations.destroyed"
    else
      flash[:warning] = t "delete_not_success"
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :gender, :birthday, :avatar, :email,
    :password, :role
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = t "not_found_item"
    redirect_to :back
  end
end
