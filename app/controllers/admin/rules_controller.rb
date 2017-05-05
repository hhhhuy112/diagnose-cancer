class Admin::RulesController < ApplicationController
  before_action :destroy_rules_c45, only: :create
  before_action :load_data, only: :create

  def index
    @search = Rule.ransack(params[:q])
    @rules = @search.result.page(params[:page]).per Settings.per_page.admin.rules
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
  end

  def create
    create_know_service = DecisionTreeService.new(@classifications, @data_cancers)
    rule = Rule.new
    create_know_service.c45_algorithm(@data_cancers, @fictions, rule)
    flash[:success] = t("admin.rules.create_rules_success")
    redirect_to admin_rules_path
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def destroy_rules_c45
    Rule.delete_all
  end

  def load_data
    @data_cancers = DataCancer.get_training_data
    @classifications = Classification.all
    @fictions = Fiction.all
  end
end
