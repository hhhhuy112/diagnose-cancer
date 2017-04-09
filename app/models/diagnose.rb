class Diagnose < ApplicationRecord
  belongs_to :classification
  has_many :data_users
end
