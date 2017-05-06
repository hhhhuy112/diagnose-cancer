class DiagnosesNaiveBayesService
  def initialize classifications, fictions, data_users, diagnose, user
    @data_users = data_users
    @classifications = classifications
    @fictions = fictions
    @num_class = @classifications.count
    @diagnose = diagnose
    @user = user
  end

  def diagnose

  end
end
