class Diagnose < ApplicationRecord
  belongs_to :user
  belongs_to :classification

  has_many :data_users, dependent: :destroy
  accepts_nested_attributes_for :data_users, reject_if: proc { |attributes| attributes["value"].blank? || attributes["fiction_id"].blank? }, allow_destroy: true

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :classification, prefix: true, allow_nil: true

  enum type_diagnose: {naise_bayes: 1, desicion_tree: 2}
end
