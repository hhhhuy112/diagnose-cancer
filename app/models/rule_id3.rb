class RuleId3 < ApplicationRecord
   belongs_to :classification

  delegate :name, to: :classification, prefix: true, allow_nil: true
end
