class Admin::ValueFictionsController < ApplicationController
   before_action :load_value_fiction, only: :update

  def index
    @search = ValueFiction.includes(:fiction).ransack(params[:q])
    @value_fictions = @search.result.page(params[:page]).per Settings.per_page.admin.value_fictions
  end

  def show

  end

  def update
    binding.pry
    if @value_fiction.update_attributes value_fiction_params
      flash[:success] = t "admin.value_fictions.updated_success"
    else
      flash[:error] = t "admin.value_fictions.updated_fail"
    end
    redirect_to admin_value_fictions_path
  end

  def edit

  end

  private

  def value_fiction_params
    params.require(:value_fiction).permit :name, :description
  end

  def load_value_fiction
    @value_fiction = ValueFiction.find_by id: params[:id]
    return if @value_fiction
    flash[:error] = t "not_found_item"
    redirect_to :back
  end
end
