class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader

  has_many :diagnose, dependent: :destroy
  has_many :groups, dependent: :destroy

  validate  :avatar_size
  validates :name, presence: true, length: {minimum: Settings.user.name_max}
  validates :gender, presence: true
  validates :birthday, presence: true
  validates :patient_code, presence: true,
    uniqueness: {case_sensitive: false}

   validate :valid_patient_code, on: [:create, :update], if: ->{self.patient_code.present?}

  enum role: {user_normal: 0, admin: 1, owner: 2}
  enum gender: {male: 0, female: 1}

  scope :not_in_group, ->group_id do
    where "id NOT IN (select user_id from user_groups where group_id = ?)", group_id
  end

  def is_user? user
    user.id == self.id
  end

  def is_owner?
    true
  end

  private

  def valid_patient_code
    str_code = self.admin? ? Settings.user.code_admin : Settings.user.code_patient
    if ConvertString.get_prefix_code(self.patient_code) != str_code
      errors.add :patient_code, I18n.t("admin.users.errors.patient_code")
    end
  end

  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end
end
