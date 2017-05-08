class StaticPagesController < ApplicationController
  before_action :load_breast_cancer, only: :breast_cancer
  before_action :load_data_mining, only: :data_mining

  def home
  end

  def breast_cancer
    @title = t "home_infor.infor_breast_cancer"
  end

  def data_mining
    @title = t "home_infor.infor_data_mining"
  end

  private

  def load_breast_cancer
    about_breast_cancers = About.load_by_type(:breast_cancer)
    @about = about_breast_cancers.last if about_breast_cancers.present?
    @fictions = Fiction.all
  end

  def load_data_mining
    about_data_minings = About.load_by_type(:data_mining)
    @about = about_data_minings.last if about_data_minings.present?
  end
end
