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
    fiction = Fiction.find_by name: name_fiction
    return [] unless fiction.present?
    fiction.value_fictions
  end

  def get_owners
    User.is_not_normal_user
  end

  def get_patients
    User.is_normal_user
  end
end
