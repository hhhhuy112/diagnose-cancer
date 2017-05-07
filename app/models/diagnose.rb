class Diagnose < ApplicationRecord
  belongs_to :owner, class_name: User.name
  belongs_to :patient, class_name: User.name
  belongs_to :classification

  has_many :data_users, dependent: :destroy
  accepts_nested_attributes_for :data_users, allow_destroy: true

  validate :check_valid_attribute

  delegate :name, :patient_code, to: :owner, prefix: true, allow_nil: true
  delegate :name, :patient_code, to: :patient, prefix: true, allow_nil: true


  delegate :name, to: :classification, prefix: true, allow_nil: true

  enum type_diagnose: {naise_bayes: 0, c45_algorithm: 1, id3_algorithm: 2}



  private

  def check_valid_attribute
    arr_valid = self.data_users.select do |data_user|
      data_user.value.present?
    end
    if arr_valid.blank?
      errors.add :errors, I18n.t("errors.diagnose.invalid_data_user")
    end
    arr_valid.blank?
  end
end
