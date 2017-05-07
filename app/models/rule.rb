class Rule < ApplicationRecord
  belongs_to :classification

  ATTR_PARAMS_DATA = [
    "clump_thickness",
    "uniformity_of_cell_size",
    "uniformity_of_cell_shape",
    "marginal_adhesion",
    "single_epithelial_cell_size",
    "bare_nuclei",
    "bland_chromatin",
    "normal_nucleoli",
    "mitoses"
  ].freeze

  delegate :name, to: :classification, prefix: true, allow_nil: true
end
