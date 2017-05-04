class ValueFiction < ApplicationRecord
  belongs_to :fiction


  validates :name, presence: true
  validates :value, presence: true

  delegate :name, to: :fiction, prefix: true, allow_nil: true
end
