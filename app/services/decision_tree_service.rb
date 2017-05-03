class DecisionTreeService
  def initialize classifications, data_cancers
    @classifications = classifications
    @abc = ""
    @array_special_fictions = []
  end

  def c45_algorithm data_cancers, fictions, rule
    arr_classification = get_classification data_cancers
    if arr_classification.count == 1
      create_rule_leaf rule, arr_classification.first
      return
    else
      math_variable_service = MathVariableService.new data_cancers, @classifications, fictions
      best_attribute = math_variable_service.get_best_fiction
      best_attribute.value_fictions.each do |value_fiction|
        data_cancers_v =  math_variable_service.get_data_cancers_for_fiction best_attribute, value_fiction
        if data_cancers_v.blank?
          classification_max = get_classification_max data_cancers
          create_rule_leaf rule, classification_max.id
          return
        else
          if rule.present?
            rule_internal = set_value_fiction best_attribute, value_fiction, rule.dup
            c45_algorithm(data_cancers_v, Fiction.all, rule_internal)
          end
        end
      end
    end
  end

  def id3_algorithm data_cancers, fictions, rule
    arr_classification = get_classification data_cancers
    if arr_classification.count == 1
      create_rule_leaf rule, arr_classification.first
      return
    elsif fictions.blank?
      classification_max = get_classification_max data_cancers
      create_rule_leaf rule, classification_max.id
      return
    else
      math_variable_service = MathVariableService.new data_cancers, @classifications, fictions
      best_attribute = math_variable_service.get_best_fiction
      @array_special_fictions << best_attribute.id
      fictions_v = Fiction.not_into_ids(@array_special_fictions.uniq)
      best_attribute.value_fictions.each do |value_fiction|
        data_cancers_v =  math_variable_service.get_data_cancers_for_fiction best_attribute, value_fiction
        if data_cancers_v.blank?
          classification_max = get_classification_max data_cancers
          create_rule_leaf rule, classification_max.id
          return
        else
          if rule.present?
            rule_internal = set_value_fiction best_attribute, value_fiction, rule.dup
            id3_algorithm(data_cancers_v, fictions_v, rule_internal)
          end
        end
      end
    end
  end

  def create_rule_leaf rule, classification_id
    if rule.present?
      rule_leaf = rule.dup
      rule_leaf.classification_id = classification_id
      rule_leaf.save
    end
  end

  def get_classification_max data_cancers
    @classifications.max_by do |classification|
      data_cancers.count{|data_cancer| data_cancer.classification_id ==  classification.id}
    end
  end

  def get_classification data_cancers
    data_cancers.pluck(:classification_id).uniq
  end

  def parent_path node
    parent_path = node.parent_path
    (parent_path << node.id).uniq
  end

  def set_value_fiction fiction, value_fiction, rule
    case fiction.name
    when Settings.fiction.clump_thickness
      rule.clump_thickness = value_fiction.value
    when Settings.fiction.uniformity_of_cell_size
      rule.uniformity_of_cell_size = value_fiction.value
    when Settings.fiction.uniformity_of_cell_shape
      rule.uniformity_of_cell_shape = value_fiction.value
    when Settings.fiction.marginal_adhesion
      rule.marginal_adhesion = value_fiction.value
    when Settings.fiction.single_epithelial_cell_size
      rule.single_epithelial_cell_size = value_fiction.value
    when Settings.fiction.bare_nuclei
      rule.bare_nuclei = value_fiction.value
    when Settings.fiction.bland_chromatin
      rule.bland_chromatin = value_fiction.value
    when Settings.fiction.normal_nucleoli
      rule.normal_nucleoli = value_fiction.value
    when Settings.fiction.mitoses
      rule.mitoses = value_fiction.value
    else
      binding.pry
    end
    rule
  end

end
