class DiagnosesController < ApplicationController
  before_action :logged_in_user
  before_action :load_fictions, only: [:create, :update]
  before_action :load_classifications, :load_user_groups, only: [:create, :update, :new, :edit]
  before_action :load_diagnose, only: [:edit, :show, :update, :destroy]
  before_action :is_owner, except: :show
  before_action :set_params_search, only: :index
  before_action :load_data_users, only: [:edit, :show]

  def index
    @title = t "admin.diagnoses.title"
    if current_user.owner?
      @search = current_user.active_diagnoses.ransack(params[:q])
    elsif current_user.admin?
      @search = Diagnose.all.ransack(params[:q])
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
    @title = t "admin.diagnoses.title"
    @diagnose = Diagnose.new
    create_data_users
  end

  def create
    @diagnose = Diagnose.new(params_diagnose)
    ActiveRecord::Base.transaction do
      if @diagnose.save
        if @diagnose.naise_bayes?
          diagose_service = DiagnosesNaiveBayesService.new(@classifications, @diagnose.data_users, @diagnose)
          diagose_service.diagnose
        else
          diagose_service = DiagnosesDesicionTreeService.new(@diagnose)
          rules = load_rules
          diagose_service.diagnose rules
        end
        @diagnose
        flash[:success] = t("admin.diagnoses.create_success")
        redirect_to @diagnose
      else
        render :new
      end
    end
  end

  def show
  end

  def update
    ActiveRecord::Base.transaction do
      if @diagnose.update_attributes params_diagnose
        if @diagnose.naise_bayes?
          diagose_service = DiagnosesNaiveBayesService.new(@classifications, @diagnose.data_users, @diagnose)
          diagose_service.diagnose
        else
          diagose_service = DiagnosesDesicionTreeService.new(@diagnose)
          rules = load_rules
          diagose_service.diagnose rules
        end
        flash[:success] = t("admin.diagnoses.update_success")
        redirect_to @diagnose
      else
        render :edit
      end
    end
  end

  def edit
    @title = t "admin.diagnoses.update_diagnose"
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

  def load_rules
    @diagnose.c45_algorithm? ? Rule.all : RuleId3.all
  end

  def set_params_search
    params[:q] ||= {}
    if params[:q][:created_at_lteq].present?
      params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day
    end
  end

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

  def load_data_users
    @data_users = @diagnose.data_users
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
