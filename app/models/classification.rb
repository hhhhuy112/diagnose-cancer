class Classification < ApplicationRecord
  has_many :data_cancers
  has_many :diagnose
end
