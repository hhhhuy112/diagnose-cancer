class Admin::AboutsController < ApplicationController
  before_action :load_fiction, only: :update

  def index
    @about = About.new
    @search = About.ransack(params[:q])
    @abouts = @search.result.page(params[:page]).per Settings.per_page.admin.abouts
  end

  def create
    @about = About.new about_params
    if @about.save
      flash[:success] = t "admin.abouts.create_about_success"
    else
      flash[:error] = t "admin.abouts.create_about_fail"
    end
    redirect_to admin_abouts_path
  end

  def show

  end

  def update
    if @about.update_attributes about_params
      flash[:success] = t "admin.abouts.updated_success"
    else
      flash[:error] = t "admin.abouts.updated_fail"
    end
    redirect_to admin_abouts_path
  end

  def edit

  end

  private

  def about_params
    params.require(:about).permit :type_about, :description, :description_vi, :link, :source
  end

  def load_fiction
    @about = About.find_by id: params[:id]
    return if @about
    flash[:error] = t "not_found_item"
    redirect_to :back
  end
end
