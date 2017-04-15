class Admin::KnowledgesController < Admin::BaseController
  before_action :destroy_knowledge, only: :create_knowledge
  before_action :load_data, only: :create_knowledge

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

  def create_knowledge
    create_know_service = CreateKnowledgeService.new(@data_cancers, @classifications, @fictions)
    create_know_service.create_knowledge
    flash[:notice] = t("admin.knowledges.create_knowledges_success")
    redirect_to admin_knowledges_path
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def destroy_knowledge
    Knowledge.delete_all
  end

  def load_data
    @data_cancers = DataCancer.all
    @classifications = Classification.all
    @fictions = Fiction.all
  end
end
