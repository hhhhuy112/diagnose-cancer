class TestAlgorithmService
  def initialize data_cancers_test, data_cancers_training
    @data_cancers_test = data_cancers_test
    @data_cancers_training = data_cancers_training
    @test_naive_bayes_service = TestNaiveBayesService.new(Classification.all)
    @test_decision_algorithm_service = TestDecisionAlgorithmService.new(Classification.all)
    @rule_c45s = Rule.all
    @rule_id3s = RuleId3.all
  end

  def test_alg
    test_naive_bayes
    test_c45_algorithm
    test_id3_algorithm
  end

  def test_naive_bayes
     naive_bayes_test_type_data @data_cancers_training, Settings.type_data.training_data
     naive_bayes_test_type_data @data_cancers_test, Settings.type_data.test_data
  end

  def test_c45_algorithm
    decision_tree_test_type_data @data_cancers_training, Settings.type_data.training_data, @rule_c45s, Settings.type_diagnose.c45_algorithm
    decision_tree_test_type_data @data_cancers_test, Settings.type_data.test_data, @rule_c45s, Settings.type_diagnose.c45_algorithm
  end

  def test_id3_algorithm
    decision_tree_test_type_data @data_cancers_training, Settings.type_data.training_data, @rule_id3s, Settings.type_diagnose.id3_algorithm
    decision_tree_test_type_data @data_cancers_test, Settings.type_data.test_data, @rule_id3s, Settings.type_diagnose.id3_algorithm
  end

  def decision_tree_test_type_data data_cancers, type_data, rules, type_diagnose
    num_true = 0
    num_fault = 0
    num_not_condition = 0
    data_cancers.each do |data_cancer|
      result = @test_decision_algorithm_service.diagnose rules, data_cancer
      (num_true += 1) if result == Settings.is_true
      (num_fault += 1) if result == Settings.is_fault
      (num_not_condition += 1) if result == Settings.is_not_condition
    end
    probability_true = (num_true.to_f / data_cancers.count).round(2)
    probability_fault = (num_fault.to_f / data_cancers.count).round(2)
    probability_not_condition = (num_not_condition.to_f / data_cancers.count).round(2)
    TestAlgorithm.create(type_diagnose: type_diagnose, type_data: type_data,
      true_probability: probability_true, fault_probability: probability_fault,
      not_condition_probability: probability_not_condition)
  end

  def naive_bayes_test_type_data data_cancers, type_data
    num_true = 0
    num_fault = 0
    num_not_condition = 0
    data_cancers.each do |data_cancer|
      result = @test_naive_bayes_service.diagnose data_cancer
      (num_true += 1) if result == Settings.is_true
      (num_fault += 1) if result == Settings.is_fault
      (num_not_condition += 1) if result == Settings.is_not_condition
    end
    probability_true = (num_true.to_f / data_cancers.count).round(2)
    probability_fault = (num_fault.to_f / data_cancers.count).round(2)
    probability_not_condition = (num_not_condition.to_f / data_cancers.count).round(2)
    TestAlgorithm.create(type_diagnose: :naise_bayes, type_data: type_data,
      true_probability: probability_true, fault_probability: probability_fault,
      not_condition_probability: probability_not_condition)
  end
end
