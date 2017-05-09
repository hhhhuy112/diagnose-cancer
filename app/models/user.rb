class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader

  has_many :active_diagnoses, class_name: Diagnose.name,
    foreign_key: "owner_id", dependent: :destroy
  has_many :passive_diagnoses, class_name: Diagnose.name,
    foreign_key: "patient_id", dependent: :destroy
  has_many :owners, through: :active_diagnoses, source: :owner
  has_many :patients, through: :passive_diagnoses, source: :patient

  has_many :groups, dependent: :destroy
  has_many :user_groups, through: :groups,dependent: :destroy
  has_one :user_group
  has_one :group, through: :user_group

  validate  :avatar_size
  validates :name, presence: true, length: {minimum: Settings.user.name_max}
  validates :gender, presence: true
  validates :birthday, presence: true
  validates :patient_code, presence: true,
    uniqueness: {case_sensitive: false}

   validate :valid_patient_code, on: [:create, :update], if: ->{self.patient_code.present?}

  enum role: {user_normal: 0, admin: 1, owner: 2}
  enum gender: {male: 0, female: 1}

  scope :not_in_group, -> do
    where "id NOT IN (select user_id from user_groups where group_id  IN (?) )", Group.all.map(&:id)
  end
  scope :is_normal_user, ->{where role: :user_normal}
  scope :is_not_normal_user, ->{where(role: [:admin, :owner])}
  scope :recent, ->{order created_at: :desc}
  scope :search_by, -> name_or_code {where "users.name LIKE ? OR users.patient_code LIKE ?", "%#{name_or_code}%", "%#{name_or_code}%"}
  scope :into_groups, ->user_ids {where(id: user_ids)}

  def is_user? user
    user.id == self.id
  end

  def is_owner?
    !self.user_normal?
  end

  def is_owner_of_group? group
    admin? || group.user_id == id
  end

  def is_owner_of? user
    member_ids = self.user_groups.pluck(:user_id)
    return false unless member_ids.present?
    member_ids.include?  user.id
  end

  private

  def valid_patient_code
    str_code = self.admin? ? Settings.user.code_admin : (self.owner? ? Settings.user.code_owner : Settings.user.code_patient)
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
