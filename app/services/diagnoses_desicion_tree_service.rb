class DiagnosesDesicionTreeService
  def initialize classifications, fictions, diagnose, user
    @data_users = get_valid_data_user diagnose.data_users
    @hash_data_users = convert_to_hash
    @classifications = classifications
    @fictions = fictions
    @diagnose = diagnose
    @user = user
  end

  def diagnose rules
    rule_accordant = rules.find do |rule|
      rule.attributes.include?(@hash_data_users)
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

  def get_valid_data_user data_users
    data_users.select do |data_user|
      data_user.value.present?
    end
  end
end
