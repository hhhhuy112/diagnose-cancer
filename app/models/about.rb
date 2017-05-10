class About < ApplicationRecord
  enum type_about: {breast_cancer: 0, data_mining: 1, data_set: 2}
  scope :load_by_type, -> type {where( type_about: type)}
end
