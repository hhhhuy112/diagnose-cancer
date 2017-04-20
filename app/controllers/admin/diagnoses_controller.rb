class Admin::DiagnosesController < ApplicationController
  before_action :load_fictions, only: :create
  before_action :load_classifications, only: :create

  def index
    @search = Diagnose.ransack(params[:q])
    @diagnoses = @search.result
    @diagnoses = @diagnoses.page(params[:page]).per Settings.per_page.admin.diagnose
     respond_to do |format|
      format.html
      format.js
     end
  end

  def new
    @diagnose = Diagnose.new
    create_data_users
  end

  def show

  end

  def create
    @diagnose = Diagnose.new(params_diagnose)
    if @diagnose.save
      diagose_service = DiagnosesService.new(@classifications, @fictions, @diagnose.data_users, @diagnose, current_user)
      diagose_service.diagnose
      @diagnose
    else
       render :new
    end
  end

  def edit

  end

  def destroy

  end

  def params_diagnose
    params.require(:diagnose).permit( :user_id ,data_users_attributes: [:id, :fiction_id, :value])
  end

  private

  def create_data_users
    Fiction.all.each do |fiction|
      @diagnose.data_users.build(fiction_id: fiction.id, name_fiction: fiction.name)
    end
  end

  def load_fictions
    @fictions = Fiction.all
  end

  def load_classifications
    @classifications = Classification.all
  end
end
