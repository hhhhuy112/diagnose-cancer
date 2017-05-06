module ApplicationHelper
  def full_title page_title = ""
    base_title = t "name_app"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-danger"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end

  def flash_message action, model, is_valid = true
    state = is_valid ? "successfully" : "fail"
    I18n.t "flash.message.#{action}.#{state}",
      model_name: I18n.t("flash.models.#{model.model_name.param_key}")
  end

  def current_index page_index, page_size, index
    (page_index - 1) * page_size + (index + 1)
  end

  def get_value_by_fiction fiction
    fiction.value_fictions
  end

  def get_fiction_by_name name_fiction
    fiction = Fiction.find_by code_data: name_fiction
    return [] unless fiction.present?
    fiction.value_fictions
  end

  def get_owners
    User.is_not_normal_user
  end

  def get_patients
    User.is_normal_user
  end

  def convert_rule_to_string rule
    arr_attr = []
    arr_attr.push("(A = A#{rule.clump_thickness})") if rule.clump_thickness.present?
    arr_attr.push("(B = B#{rule.uniformity_of_cell_size})") if rule.uniformity_of_cell_size.present?
    arr_attr.push("(C = C#{rule.uniformity_of_cell_shape})") if rule.uniformity_of_cell_shape.present?
    arr_attr.push("(D = A#{rule.marginal_adhesion})") if rule.marginal_adhesion.present?
    arr_attr.push("(E = E#{rule.single_epithelial_cell_size})") if rule.single_epithelial_cell_size.present?
    arr_attr.push("(F = F#{rule.bare_nuclei})") if rule.bare_nuclei.present?
    arr_attr.push("(G = G#{rule.bland_chromatin})") if rule.bland_chromatin.present?
    arr_attr.push("(H = H#{rule.normal_nucleoli})") if rule.normal_nucleoli.present?
    arr_attr.push("(I = I#{rule.mitoses})") if rule.mitoses.present?
    arr_attr.join(" And ")
  end

  def get_str_type_diagnose diagnose
    return I18n.t("admin.diagnoses.naise_bayes") if diagnose.naise_bayes?
    return I18n.t("admin.diagnoses.c45_algorithm") if diagnose.c45_algorithm?
    return I18n.t("admin.diagnoses.id3_algorithm") if diagnose.id3_algorithm?
  end

  def get_result diagnose
    diagnose.classification_id.present? ? diagnose.classification_name : I18n.t("admin.diagnoses.not_condition")
  end
end
