class AboutsController < ApplicationController
  before_action :load_about, only: :show
  def show
  end

  private

  def load_about
    @about = About.find_by id: params[:id]
    return if @about
    flash[:warning] = t "not_found_item"
    redirect_to :back
  end

end
