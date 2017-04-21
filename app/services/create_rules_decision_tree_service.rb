class CreateRulesDecisionTreeService
  def initialize data_cancers, classifications, fictions
    @data_cancers = data_cancers
    @classifications = classifications
    @fictions = fictions
    @entropy = math_entropy
    @array_special_fictions = []
    @abc = ""
    @count = 0
  end

  def id3_algorithm data_cancers, fictions
    arr_classification = get_classification data_cancers
    if arr_classification.count == 1
      #tao nut root cua cay quyet dinh
      @abc +=   "lop:" + "#{arr_classification.first}"  + "\n"
      @abc += "-------------------------------------end-node1------------------------------------ \n"
      return
    elsif fictions.blank?
      classification_max = @classifications.max_by do |classification|
        data_cancers.count{|data_cancer| data_cancer.classification_id ==  classification.id}
      end

      @abc +=  "lop_nhieu: #{classification_max.name} " + "\n"
      @abc += "-------------------------------------end-node1------------------------------------ \n"

      return
    else
      # lay best attribute
      best_attribute = get_best_fiction(fictions, data_cancers)
      # xoa best_attribute
      @array_special_fictions << best_attribute
      fictions_v = Fiction.not_into_ids(@array_special_fictions.pluck(:id))
      #voi moi v thuoc best_attribute
      @abc += "-------------------------------------start-node------------------------------------ \n"
      @abc += "-------------------------------------nhanh"+ "#{best_attribute.name}" + "------------------------------------\n"

      best_attribute.value_fictions.each do |value_fiction|
        @abc +=  "value" + "#{value_fiction.value}----- \n"
        data_cancers_v =  get_data_cancers_for_fictions best_attribute, value_fiction.value
        id3_algorithm(data_cancers_v, fictions_v)
      end
    end
    @abc
  end

  def write_file text

  end





  def get_best_fiction fictions, data_cancers
    fictions.max_by do |fiction|
      math_gain(fiction, data_cancers)
    end
  end

  def math_gain fiction, data_cancers
    gain_value = 0
    fiction.value_fictions.each do |value_fiction|
      data_cancers_v =  get_data_cancers_for_fictions fiction, value_fiction.value
      probability = data_cancers_v.count.to_f / data_cancers.count
      entropy = math_entropy_for_value fiction, value_fiction.value
      gain_value -= probability * entropy
      if gain_value.nan?
        binding.pry
      end
    end
    (@entropy - gain_value)
  end

  def math_entropy_for_value fiction, value
    entropy = 0
    @classifications.each do |classification|
      probability = (number_data_cancers_by_fiction_value(classification.id, fiction, value)).to_f /  @data_cancers.count
      entropy -= (probability * Math.log2(probability)) unless probability.zero?
    end
    entropy
  end

  def math_entropy
    entropy = 0
    @classifications.each do |classification|
      probability = (classification.data_cancers.count).to_f /  @data_cancers.count
      entropy -= probability * Math.log2(probability)
    end
    entropy
  end

  def get_data_cancers_for_fictions fiction, value
    case fiction.name
    when Settings.fiction.clump_thickness
      DataCancer.is_clump_thickness(value)
    when Settings.fiction.uniformity_of_cell_size
      DataCancer.is_uniformity_of_cell_size(value)
    when Settings.fiction.uniformity_of_cell_shape
      DataCancer.is_uniformity_of_cell_shape(value)
    when Settings.fiction.marginal_adhesion
      DataCancer.is_marginal_adhesion(value)
    when Settings.fiction.single_epithelial_cell_size
      DataCancer.is_single_epithelial_cell_size(value)
    when Settings.fiction.bare_nuclei
      DataCancer.is_bare_nuclei(value)
    when Settings.fiction.bland_chromatin
      DataCancer.is_band_romatin(value)
    when Settings.fiction.normal_nucleoli
      DataCancer.is_nomal_nucleoli(value)
    when Settings.fiction.mitoses
      DataCancer.is_mitoses(value)
    else
      []
    end
  end

  def number_data_cancers_by_fiction_value classification_id, fiction, value
    case fiction.name
    when Settings.fiction.clump_thickness
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_clump_thickness(value).count
    when Settings.fiction.uniformity_of_cell_size
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_uniformity_of_cell_size(value).count
    when Settings.fiction.uniformity_of_cell_shape
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_uniformity_of_cell_shape(value).count
    when Settings.fiction.marginal_adhesion
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_marginal_adhesion(value).count
    when Settings.fiction.single_epithelial_cell_size
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_single_epithelial_cell_size(value).count
    when Settings.fiction.bare_nuclei
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_bare_nuclei(value).count
    when Settings.fiction.bland_chromatin
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_band_romatin(value).count
    when Settings.fiction.normal_nucleoli
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_nomal_nucleoli(value).count
    when Settings.fiction.mitoses
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_mitoses(value).count
    else
      0
    end
  end

  def get_classification data_cancers
    data_cancers.pluck(:classification_id).uniq
  end
end
