class DiagnosesController < ApplicationController
  before_action :logged_in_user
  before_action :load_fictions, only: :create
  before_action :load_classifications, only: :create
  before_action :load_diagnose, only: [:edit, :show, :update]

  def show
    @data_users = @diagnose.data_users
  end

  def edit

  end

  def destroy

  end

  def params_diagnose
    params.require(:diagnose).permit( :user_id ,data_users_attributes: [:id, :fiction_id, :name_fiction,:value])
  end

  private

  def create_data_users
    Fiction.all.each do |fiction|
      @diagnose.data_users.build(fiction_id: fiction.id, name_fiction: fiction.name)
    end
  end

  def load_diagnose
    @diagnose = Diagnose.find_by id: params[:id]
    return if @diagnose
    flash[:error] = t "not_found_item"
    redirect_to :back
  end

  def load_fictions
    @fictions = Fiction.all
  end

  def load_classifications
    @classifications = Classification.all
  end
end
