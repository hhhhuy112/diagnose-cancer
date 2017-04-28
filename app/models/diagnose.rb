class Diagnose < ApplicationRecord
  belongs_to :owner, class_name: User.name
  belongs_to :patient, class_name: User.name
  belongs_to :classification

  has_many :data_users, dependent: :destroy
  accepts_nested_attributes_for :data_users, allow_destroy: true

  delegate :name, :patient_code, to: :owner, prefix: true, allow_nil: true
  delegate :name, :patient_code, to: :patient, prefix: true, allow_nil: true


  delegate :name, to: :classification, prefix: true, allow_nil: true

  enum type_diagnose: {naise_bayes: 1, desicion_tree: 2}
end
