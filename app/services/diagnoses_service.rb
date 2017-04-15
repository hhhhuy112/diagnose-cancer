class DiagnosesService
  def initialize classifications, fictions, data_users, diagnose, user
    @data_users = data_users
    @classifications = classifications
    @fictions = fictions
    @num_class = @classifications.count
    @diagnose = diagnose
    @user = user
  end

  def diagnose
    max = 0
    classification_max = nil
    @classifications.each do |classification|
      abc = math_probability_model_by_classification(classification)
      if abc>max
        max = abc
        classification_max = classification
      end
    end
    @diagnose.update(classification_id: classification_max, user_id: @user.id, result: max)
    # @classifications.max_by do |classification|
    #   math_probability_model_by_classification(classification)
    # end
  end

  def math_probability_model_by_classification classification
    probability_model = classification.probability
    @data_users.each do |data_user|
      if !data_user.value.zero?
        knowledge = Knowledge.find_by classification_id: classification.id, fiction_id: data_user.fiction_id, value: data_user.value
        probability_model *= knowledge.probability
      end
    end
    probability_model
  end

end

