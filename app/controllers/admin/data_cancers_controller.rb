class Admin::DataCancersController < Admin::BaseController
  def index
    @data_cancers = DataCancer.page(params[:page]).per 5
  end

  def new
    @data_cancer = DataCancer.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
