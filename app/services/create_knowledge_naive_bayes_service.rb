class CreateKnowledgeNaiveBayesService
  def initialize data_cancers, classifications, fictions
    @data_cancers = data_cancers
    @classifications = classifications
    @fictions = fictions
    @num_class = @classifications.count
  end

  def create_knowledge
    @classifications.each do |classification|
      classificate_number = classification.data_cancers.count
      @fictions.each do |fiction|
        value_fiction_number = fiction.value_fictions.count
        fiction.value_fictions.each do |value_fiction|
          probability = get_probability classification.id, fiction, value_fiction.value, classificate_number, value_fiction_number
          Knowledge.create(classification_id: classification.id, fiction_id: fiction.id, value: value_fiction.value, probability: probability)
        end
      end
    end
  end

  def get_probability classification_id, fiction, value, classificate_number, value_fiction_number
    case fiction.name
    when Settings.fiction.clump_thickness
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_clump_thickness(value).count
      (num_fiction_of_class + @num_class).to_f / (classificate_number + value_fiction_number)
    when Settings.fiction.uniformity_of_cell_size
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_uniformity_of_cell_size(value).count
      (num_fiction_of_class + @num_class).to_f / (classificate_number + value_fiction_number)
    when Settings.fiction.uniformity_of_cell_shape
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_uniformity_of_cell_shape(value).count
      (num_fiction_of_class + @num_class).to_f / (classificate_number + value_fiction_number)
    when Settings.fiction.marginal_adhesion
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_marginal_adhesion(value).count
      (num_fiction_of_class + @num_class).to_f / (classificate_number + value_fiction_number)
    when Settings.fiction.single_epithelial_cell_size
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_single_epithelial_cell_size(value).count
      (num_fiction_of_class + @num_class).to_f / (classificate_number + value_fiction_number)
    when Settings.fiction.bare_nuclei
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_bare_nuclei(value).count
      (num_fiction_of_class + @num_class).to_f / (classificate_number + value_fiction_number)
    when Settings.fiction.bland_chromatin
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_band_romatin(value).count
      (num_fiction_of_class + @num_class).to_f / (classificate_number + value_fiction_number)
    when Settings.fiction.normal_nucleoli
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_nomal_nucleoli(value).count
      (num_fiction_of_class + @num_class).to_f / (classificate_number + value_fiction_number)
    when Settings.fiction.mitoses
      num_fiction_of_class = DataCancer.is_classification(classification_id).is_mitoses(value).count
      (num_fiction_of_class + @num_class).to_f / (classificate_number + value_fiction_number)
    else
      0
    end
  end
end
