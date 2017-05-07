class TestDecisionAlgorithmService
  def initialize classifications
  end

   def diagnose rules, data_cancer
    rule_accordant = rules.find do |rule|
      hash_rule = convert_rule_to_hash rule
      hash_data = filter_hash_data_user hash_rule.keys, data_cancer
      (hash_rule == hash_data)
    end
    return Settings.is_not_condition unless rule_accordant.present?
    (rule_accordant.classification_id == data_cancer.classification_id) ? Settings.is_true : Settings.is_fault
  end

  def convert_to_hash
    hash_attr = {}
    @data_users.each do |data_user|
      code_data = data_user.fiction_code_data
      hash_attr[code_data] = data_user.value
    end
    hash_attr
  end

  def convert_rule_to_hash rule
    rule.attributes.select do |key, value|
      Rule::ATTR_PARAMS_DATA.include?(key) && value.present? && !value.zero?
    end
  end

  def filter_hash_data_user arr_keys, data_cancer
    data_cancer.attributes.select do |key, value|
      arr_keys.include?(key)
    end
  end
end
