class Knowledge < ApplicationRecord
  belongs_to :fiction
  belongs_to :classification

  delegate :name, to: :classification, prefix: true, allow_nil: true
  delegate :name, to: :fiction, prefix: true, allow_nil: true
end
