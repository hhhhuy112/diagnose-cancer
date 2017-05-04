class Admin::FictionsController < ApplicationController
  before_action :load_fiction, only: :update

  def index
    @search = Fiction.ransack(params[:q])
    @fictions = @search.result.page(params[:page]).per Settings.per_page.admin.fictions
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show

  end

  def update
    if @fiction.update_attributes fiction_params
      flash[:success] = t "admin.fictions.updated_success"
    else
      flash[:error] = t "admin.fictions.updated_fail"
    end
    redirect_to admin_fictions_path
  end

  def edit

  end

  private

  def fiction_params
    params.require(:fiction).permit :description
  end

  def load_fiction
    @fiction = Fiction.find_by id: params[:id]
    return if @fiction
    flash[:error] = t "not_found_item"
    redirect_to :back
  end
end
