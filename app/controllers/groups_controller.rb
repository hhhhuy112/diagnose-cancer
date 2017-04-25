class GroupsController < ApplicationController
  before_action :new_group, only: :index
  before_action :load_group, only: [:show, :edit, :destroy, :update]

  def index
    @search = Group.ransack(params[:q])
    @groups = @search.result
    @groups = @groups.page(params[:page]).per Settings.per_page.admin.group
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def add_member

  end

  def delete_member

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

  def new_group
    @group = Group.new
  end
end
