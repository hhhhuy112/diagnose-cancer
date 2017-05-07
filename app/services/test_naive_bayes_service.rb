class TestNaiveBayesService
  def initialize classifications
    @classifications = classifications
    @num_class = @classifications.count
  end

  def diagnose data_cancer
    max_probability = 0
    classification_max = nil
    @classifications.each do |classification|
      probability_model = math_probability_model_by_classification(classification, data_cancer)
      if probability_model > max_probability
        max_probability = probability_model
        classification_max = classification
      end
    end
    return Settings.is_not_condition unless classification_max.present?
    (classification_max.id == data_cancer.classification_id) ? Settings.is_true : Settings.is_fault
  end

  def math_probability_model_by_classification classification, data_cancer
    probability_model = classification.probability
    data_cancer.attributes.each do |key, value|
      if DataCancer::ATTR_PARAMS_DATA.include?(key) && !value.zero?
        fiction = Fiction.find_by code_data: key
        knowledge = Knowledge.find_by classification_id: classification.id, fiction_id: fiction.id, value: value
        probability_model *= knowledge.probability
      end
    end
    probability_model
  end
end
