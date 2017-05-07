class Admin::TestAlgorithmsController < ApplicationController
  before_action :load_data_cancers ,only: :create

  def index

  end

  def create
    TestAlgorithm.delete_all
    test_algorithm_service = TestAlgorithmService.new(@data_cancers_test, @data_cancers_training).test_alg
  end

  private

  def load_data_cancers
    @data_cancers_test = DataCancer.get_test_data
    @data_cancers_training = DataCancer.get_training_data
  end
end
