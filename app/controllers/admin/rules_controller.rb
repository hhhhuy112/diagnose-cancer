class Admin::RulesController < ApplicationController
  before_action :destroy_rules, only: :create
  before_action :load_data, only: :create

  def index
    @search = Knowledge.ransack(params[:q])
    @knowledges = @search.result
    @knowledges = @knowledges.page(params[:page]).per Settings.per_page.admin.knowledge
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
  end

  def create
    create_know_service = CreateRulesDecisionTreeService.new(@data_cancers, @classifications, @fictions)
    abc = create_know_service.id3_algorithm(@data_cancers, @fictions)
     binding.pry
     f = File.open("/home/ubuntu/datn/data/tree.txt", "w")
     f.write(abc[:abc])
     f.close
    flash[:success] = t("admin.knowledges.create_knowledges_success")
    redirect_to admin_knowledges_path
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def destroy_rules
    Rule.delete_all
  end

  def load_data
    @data_cancers = DataCancer.all
    @classifications = Classification.all
    @fictions = Fiction.all
  end
end
