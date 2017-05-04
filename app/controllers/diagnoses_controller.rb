class DiagnosesController < ApplicationController
  before_action :logged_in_user
  before_action :load_fictions, only: [:create, :update]
  before_action :load_classifications, :load_user_groups, only: [:create, :update, :new, :edit]
  before_action :load_diagnose, only: [:edit, :show, :update, :destroy]
  before_action :is_owner, except: :show


  def index
    if current_user.is_owner?
      @search = current_user.active_diagnoses.ransack(params[:q])
    else
      @search = current_user.passive_diagnoses.ransack(params[:q])
    end
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

  def create
    @diagnose = Diagnose.new(params_diagnose)
    ActiveRecord::Base.transaction do
      if @diagnose.save
        if @diagnose.naise_bayes?
          diagose_service = DiagnosesNaiveBayesService.new(@classifications, @fictions, @diagnose.data_users, @diagnose, current_user)
          diagose_service.diagnose
        else
          diagose_service = DiagnosesService.new(@classifications, @fictions, @diagnose.data_users, @diagnose, current_user)
          diagose_service.diagnose
        end
        @diagnose
        flash[:success] = t("admin.diagnoses.create_success")
        redirect_to @diagnose
      else
        flash[:error] = t("admin.diagnoses.create_fail")
        render :new
      end
    end
  end

  def show
    @data_users = @diagnose.data_users
  end

  def update
    if @diagnose.update_attributes params_diagnose
      diagose_service = DiagnosesNaiveBayesService.new(@classifications, @fictions, @diagnose.data_users, @diagnose, current_user)
      diagose_service.diagnose
      flash[:success] = t("admin.diagnoses.update_success")
      redirect_to @diagnose
    else
      flash[:error] = t("admin.diagnoses.update_fail")
      render :show
    end
  end

  def edit

  end


  def destroy
    if @diagnose.destroy
      flash[:success] = t "admin.diagnoses.delete_success"
    else
      flash[:error] = t "admin.diagnoses.delete_fail"
    end
    redirect_to admin_diagnoses_path
  end

  private

  def params_diagnose
    params.require(:diagnose).permit( :patient_id , :type_diagnose, data_users_attributes: [:id, :fiction_id, :name_fiction, :value]).merge!(owner_id: "#{current_user.id}")
  end

  def create_data_users
    Fiction.all.each do |fiction|
      @diagnose.data_users.build(fiction_id: fiction.id, name_fiction: fiction.name)
    end
  end

  def load_diagnose
    @diagnose = Diagnose.find_by id: params[:id]
    return if @diagnose
    flash[:warning] = t "not_found_item"
    redirect_to :back
  end

  def load_user_groups
    @user_insides = if current_user.admin?
      User.is_normal_user
    else
      current_user.groups.map(&:users).sum
    end
  end

  def load_fictions
    @fictions = Fiction.all
  end

  def load_classifications
    @classifications = Classification.all
  end
end
