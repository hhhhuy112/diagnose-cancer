class DataUser < ApplicationRecord
  belongs_to :fiction
  belongs_to :diagnose, optional: true

  delegate :name, :code_data, to: :fiction, prefix: true, allow_nil: true
end
