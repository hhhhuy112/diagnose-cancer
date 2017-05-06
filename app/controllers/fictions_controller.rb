class FictionsController < ApplicationController
  before_action :load_fiction, only: :show

  def index
    Fictions.all
  end

  def show
  end

  private

  def load_fiction
    @fiction = Fiction.find_by id: params[:id]
    return if @fiction
    flash[:error] = t "not_found_item"
    redirect_to :back
  end
end
