class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  delegate :id, :name, :avatar, :gender, :patient_code, to: :user,
    prefix: true, allow_nil: true
  delegate :id, :name, to: :group, prefix: true, allow_nil: true

   scope :of_user_ids, -> user_ids{where user_id: user_ids}

end
