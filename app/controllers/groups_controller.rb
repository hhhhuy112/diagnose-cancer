class GroupsController < ApplicationController
  before_action :new_group, only: :index
  before_action :load_group, only: [:show, :edit, :destroy, :update, :add_member, :delete_member]
  before_action :is_owner

  def index
    @title = t "groups.list_groups"
    @search = current_user.admin? ? Group.ransack(params[:q]) : current_user.groups.ransack(params[:q])
    @groups = @search.result
    @groups = @groups.page(params[:page]).per Settings.per_page.admin.group
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @title = t "groups.information_group"
    user_ids = @group.users.is_normal_user.search_by(params[:search]).pluck(:id)
    @users_inside = @group.user_groups.of_user_ids(user_ids).includes(:user)
    init_variables
    respond_to do |format|
      format.html
      format.js
    end
  end

  def add_member
    assign_user params[:user_groups][:user_ids], @group
    redirect_to :back
  end

  def delete_member
    @user_ids = params[:user_ids].strip.split(",").map(&:to_i)
    unassign_user @user_ids, @group
    redirect_to :back
  end

  private

  def assign_user user_ids, group
    assign_user = AssignUserService.new
    .create user_ids, group, t("user_groups.create_not_successfully")
    message_notice t("user_groups.create_successfully"), assign_user
  end

  def unassign_user user_ids, group
    unassign_user = AssignUserService.new
    .destroy user_ids, group, t("user_groups.delete_not_successfully")
    message_notice t("user_groups.delete_successfully"), unassign_user
  end

  def group_params
    params.require(:group).permit :name, :user_id, :image, :description
  end

  def load_group
    @group = Group.find_by id: params[:id]
    return if @group
    flash[:error] = t "not_found_item"
    redirect_to :back
  end

  def new_group
    @group = Group.new
  end



  def message_notice message_success, type
    return flash[:error] = type[:error] unless type[:success]
    flash[:success] = message_success
  end

  def init_variables
    @user_group = UserGroup.new
    @users_outside = User.not_in_group(@group.id).is_normal_user.includes(:groups)
  end
end
