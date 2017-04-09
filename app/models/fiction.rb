class Fiction < ApplicationRecord
  has_many :value_fictions
  has_many :knowledges
  has_many :data_users
end
