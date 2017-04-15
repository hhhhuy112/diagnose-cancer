class Diagnose < ApplicationRecord
  belongs_to :classification, dependent: :destroy
  has_many :data_users
  accepts_nested_attributes_for :data_users, reject_if: proc { |attributes| attributes["value"].blank? || attributes["fiction_id"].blank? }, allow_destroy: true
end
