class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: [:update, :edit, :show]
  def index

  end

  def new

  end

  def create

  end

  def show
  end

  def edit

  end

  def update
    if @user.update_attributes user_params
      flash[:notice] = t "devise.registrations.updated"
      redirect_to admin_user_path
    else
      render :edit
    end
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit :name, :gender, :birthday, :avatar, :email,
      :password, :password_confirmation, :role
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = t "not_found_item"
    redirect_to :back
  end
end
