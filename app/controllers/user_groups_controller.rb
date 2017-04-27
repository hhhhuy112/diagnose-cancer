class UserGroupsController < ApplicationController
  class Dashboard::UserGroupsController < DashboardController
    before_action :load_group, only: [:index, :create, :destroy]

    def index
     binding.pry
    end

    def create

    end

    def destroy

    end

    private

    def assign_user user_ids, group
      assign_user = AssignUserService.new
      .create user_ids, group, t(".create_not_successfully"), Settings.user.user_group
      message_notice t(".create_successfully"), assign_user
    end

    def unassign_user user_ids, group
      unassign_user = AssignUserService.new
      .destroy user_ids, group, t(".delete_not_successfully")
      message_notice t(".delete_successfully"), unassign_user
    end

    def message_notice message_success, type
      return flash[:error] = type[:error] unless type[:success]
      flash[:success] = message_success
    end

    def init_variables
      @user_group = UserGroup.new
      @users_outside = User.not_in_group(@group.id).includes(:groups)
    end
end
