class Classification < ApplicationRecord
  has_many :data_cancers, dependent: :destroy
  has_many :diagnose, dependent: :destroy
end
