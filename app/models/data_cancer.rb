class DataCancer < ApplicationRecord
  belongs_to :classification
  enum value: [1,2,3,4,5,6,7,8,9,10]
  ATTR_PARAMS = [
    :sample_code_number,
    :clump_thickness,
    :uniformity_of_cell_size,
    :uniformity_of_cell_shape,
    :marginal_adhesion,
    :single_epithelial_cell_size,
    :bare_nuclei,
    :bland_chromatin,
    :normal_nucleoli,
    :mitoses,
    :classification_id,
  ].freeze

  delegate :name, to: :classification, prefix: true, allow_nil: true

  scope :is_clump_thickness, -> value do
    where clump_thickness: value
  end

  scope :is_uniformity_of_cell_size, -> value do
    where uniformity_of_cell_size: value
  end

  scope :is_uniformity_of_cell_shape, -> value do
    where uniformity_of_cell_shape: value
  end

  scope :is_marginal_adhesion, -> value do
    where marginal_adhesion: value
  end

  scope :is_single_epithelial_cell_size, -> value do
    where single_epithelial_cell_size: value
  end

  scope :is_bare_nuclei, -> value do
    where bare_nuclei: value
  end

  scope :is_bland_chromatin, -> value do
    where bland_chromatin: value
  end

  scope :is_normal_nucleoli, -> value do
    where normal_nucleoli: value
  end

  scope :is_mitoses, -> value do
    where mitoses: value
  end

  scope :is_classification, -> classification_id do
    where classification_id: classification_id
  end
end
