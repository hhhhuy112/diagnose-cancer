class Admin::GroupsController < ApplicationController
  before_action :new_group, only: :index
  before_action :load_group, only: [:show, :edit, :destroy, :update]
  before_action :load_user_groups, only: [:show, :edit]
  before_action :load_users, only: [:show]

  def index
    @search = Group.ransack(params[:q])
    @groups = @search.result
    @groups = @groups.page(params[:page]).per Settings.per_page.admin.group
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @group = Group.new group_params
    if @group.save
      flash[:success] = t "admin.groups.create_group_success"
    else
      flash[:error] = t "admin.groups.create_group_fail"
    end
    redirect_to groups_path
  end

  def show
  end

  def update
    if @group.update_attributes group_params
      flash[:success] = t "admin.groups.update_group_success"
    else
      flash[:error] = t "admin.groups.update_group_fail"
    end
    redirect_to groups_path
  end

  def destroy
    if @group.destroy
      flash[:success] =  t "admin.groups.delete_group_success"
    else
      flash[:error] = t "admin.groups.delete_group_fail"
    end
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit :name, :user_id, :image
  end

  def load_group
    @group = Group.find_by id: params[:id]
    return if @group
    flash[:error] = t "not_found_item"
    redirect_to :back
  end

  def load_user_groups
    @user_groups = @group.user_groups
  end

  def load_users
    @users= @group.users
  end

  def new_group
    @group = Group.new
  end
end
