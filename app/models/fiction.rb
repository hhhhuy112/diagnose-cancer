class Fiction < ApplicationRecord
  has_many :value_fictions, dependent: :destroy
  has_many :knowledges, dependent: :destroy
  has_many :data_users, dependent: :destroy

  scope :not_into_ids, -> ids do
    where.not(id: ids)
  end

end
