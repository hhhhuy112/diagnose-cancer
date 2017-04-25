class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  delegate :id, :name, :avatar, :gender, :patient_code, to: :user,
    prefix: true, allow_nil: true
  delegate :id, :name, to: :group, prefix: true, allow_nil: true
end
