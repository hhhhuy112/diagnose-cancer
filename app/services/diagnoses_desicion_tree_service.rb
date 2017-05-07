class DiagnosesDesicionTreeService
  def initialize diagnose
    @data_users = get_valid_data_user diagnose.data_users
    @hash_data_users = convert_to_hash
    @diagnose = diagnose
  end

  def diagnose rules
    rule_accordant = rules.find do |rule|
      hash_rule = convert_rule_to_hash rule
      hash_data = filter_hash_data_user hash_rule.keys
      (hash_rule == hash_data)
    end
    if rule_accordant.present?
      @diagnose.update(classification_id: rule_accordant.classification_id)
    end
  end

  def convert_to_hash
    hash_attr = {}
    @data_users.each do |data_user|
      code_data = data_user.fiction_code_data
      hash_attr[code_data] = data_user.value
    end
    hash_attr
  end


  def filter_hash_data_user arr_keys
    @hash_data_users.select do |key, value|
      arr_keys.include?(key)
    end
  end

  def get_valid_data_user data_users
    data_users.select do |data_user|
      data_user.value.present?
    end
  end

  def convert_rule_to_hash rule
    rule.attributes.select do |key, value|
      Rule::ATTR_PARAMS_DATA.include?(key) && value.present? && !value.zero?
    end
  end
end
