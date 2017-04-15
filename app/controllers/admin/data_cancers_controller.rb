class Admin::DataCancersController < Admin::BaseController
  before_action :load_data_cancer, only: [:update, :edit, :show, :destroy]


  def index
    @search = DataCancer.ransack(params[:q])
    @data_cancers = @search.result
    @data_cancers = @data_cancers.page(params[:page]).per Settings.per_page.admin.data_cancer
     respond_to do |format|
      format.html
      format.js
     end
  end

  def new
    @data_cancer = DataCancer.new
  end

  def show
  end

  def create

  end

  def edit

  end

  def update
    if @data_cancer.update_attributes data_cancer_params
      flash[:notice] = t "admin.data_cancers.updated_success"
      redirect_to [:admin, @data_cancer]
    else
      render :edit
    end
  end

  def destroy
    if @data_cancer.destroy
      flash[:notice] = t("delete") + t("success")
      redirect_to admin_data_cancers_path
    else
      flash[:error] = t("delete") + t("fail")
      redirect_to admin_data_cancers_path
    end
  end

  private

  def load_data_cancer
    @data_cancer = DataCancer.find_by id: params[:id]
    return if @data_cancer.present?
    flash[:error] = t "not_found_item"
    redirect_to :back
  end

  def data_cancer_params
    params.require(:data_cancer).permit DataCancer::ATTR_PARAMS
  end
end
