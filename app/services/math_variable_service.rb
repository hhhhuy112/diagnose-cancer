class MathVariableService
  def initialize data_cancers, classifications, fictions
    @data_cancers = data_cancers
    @classifications = classifications
    @fictions = fictions
    @num_class = @classifications.count
    @expect_information_value = math_expect_information_value @data_cancers
  end


  def get_best_fiction
    @fictions.max_by do |fiction|
        math_gain_ratio fiction
    end
  end

  def math_gain_ratio fiction
    (math_gain_infor(fiction)).round(2)
  end

  def math_gain_infor fiction
     (@expect_information_value - math_sum_of_gain_infor(fiction))
  end

  def math_sum_of_gain_infor fiction
    fiction.value_fictions.sum do |value_fiction|
      data_cancers = get_data_cancers_for_fiction fiction , value_fiction
      if data_cancers.blank?
        0
      else
        math_i_value = math_expect_information_value data_cancers
        (data_cancers.count.to_f / @data_cancers.count) * math_i_value
      end
    end
  end

  def math_expect_information_value data_cancers
    @classifications.sum do |classification|
      probability = (math_number_classfication(classification, data_cancers).to_f /  data_cancers.count)
      probability.zero? ? 0 : - (probability * Math.log2(probability))
    end
  end

  def math_split_infor fiction
     sum = fiction.value_fictions.sum do |value_fiction|
      data_cancers = get_data_cancers_for_fiction fiction , value_fiction
      probability = (data_cancers.count.to_f / @data_cancers.count)
      (probability * Math.log2(probability))
    end
    -sum
  end

  def get_data_cancers_for_fiction fiction , value_fiction
    @data_cancers.select{|data_cancer| condition_data_cancer?(fiction, value_fiction, data_cancer)}
  end

  def math_number_classfication classification, data_cancers
    data_cancers.select{|data_cancer| (data_cancer.classification_id == classification.id)}.count
  end

  def condition_data_cancer? fiction, value_fiction, data_cancer
    case fiction.code_data
    when Settings.fiction.clump_thickness
      data_cancer.clump_thickness == value_fiction.value
    when Settings.fiction.uniformity_of_cell_size
      data_cancer.uniformity_of_cell_size == value_fiction.value
    when Settings.fiction.uniformity_of_cell_shape
      data_cancer.uniformity_of_cell_shape == value_fiction.value
    when Settings.fiction.marginal_adhesion
      data_cancer.marginal_adhesion == value_fiction.value
    when Settings.fiction.single_epithelial_cell_size
      data_cancer.single_epithelial_cell_size == value_fiction.value
    when Settings.fiction.bare_nuclei
      data_cancer.bare_nuclei == value_fiction.value
    when Settings.fiction.bland_chromatin
      data_cancer.bland_chromatin == value_fiction.value
    when Settings.fiction.normal_nucleoli
      data_cancer.normal_nucleoli == value_fiction.value
    when Settings.fiction.mitoses
      data_cancer.mitoses == value_fiction.value
    else
      false
    end
  end
end
