class Group < ApplicationRecord
  mount_uploader :image, GroupImageUploader

  belongs_to :owner, class_name: User.name, foreign_key: :user_id

  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups

  validates :name, presence: true
  validates :user_id, presence: true
end
