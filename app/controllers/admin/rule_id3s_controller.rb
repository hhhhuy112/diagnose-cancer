class Admin::RuleId3sController < ApplicationController
  before_action :destroy_rules_id3, only: :create
  before_action :load_data, only: :create

  def index
    @search = RuleId3.ransack(params[:q])
    @rules = @search.result.page(params[:page]).per Settings.per_page.admin.rules
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
  end

  def create
    create_know_service = DecisionTreeService.new(@classifications, DataCancer.all)
    rule = RuleId3.new
    create_know_service.id3_algorithm(@data_cancers, @fictions, rule)
    flash[:success] = t("admin.rules.create_rules_success")
    redirect_to admin_rule_id3s_path
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def destroy_rules_id3
    RuleId3.delete_all
  end

  def load_data
    @data_cancers = DataCancer.all
    @classifications = Classification.all
    @fictions = Fiction.all
  end
end
