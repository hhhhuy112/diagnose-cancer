class DataCancer < ApplicationRecord
  belongs_to :classification

  ATTR_PARAMS = [
    :sample_code_number,
    :clump_thickness,
    :uniformity_of_cell_size,
    :uniformity_of_cell_shape,
    :marginal_adhesion,
    :single_epithelial_cell_size,
    :bare_nuclei,
    :band_romatin,
    :nomal_nucleoli,
    :mitoses,
    :classification_id,
  ].freeze

  enum value: [0,1,2,3,4,5,6,7,8,9,10]

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

  scope :is_band_romatin, -> value do
    where band_romatin: value
  end

  scope :is_nomal_nucleoli, -> value do
    where nomal_nucleoli: value
  end

  scope :is_mitoses, -> value do
    where mitoses: value
  end

  scope :is_classification, -> classification_id do
    where classification_id: classification_id
  end
end
