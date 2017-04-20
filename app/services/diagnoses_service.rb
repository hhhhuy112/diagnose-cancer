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
    max_probability = 0
    classification_max = nil
    @classifications.each do |classification|
      probability_model = math_probability_model_by_classification(classification)
      if probability_model > max_probability
        max_probability = probability_model
        classification_max = classification
      end
    end
    @diagnose.update(classification_id: classification_max.id, user_id: @user.id, result: max_probability)
  end

  def math_probability_model_by_classification classification
    probability_model = classification.probability
    @data_users.each do |data_user|
      if data_user.value.present?
        knowledge = Knowledge.find_by classification_id: classification.id, fiction_id: data_user.fiction_id, value: data_user.value
        probability_model *= knowledge.probability
      end
    end
    probability_model
  end

end

