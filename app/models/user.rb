class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader
  has_many :diagnose
  validate  :avatar_size
  validates :name, presence: true, length: {minimum: Settings.user.name_max}
  validates :gender, presence: true
  validates :birthday, presence: true

  enum role: {user_normal: 0, admin: 1}
  enum gender: {male: 0, female: 1}

  def is_user? user
    user.id == self.id
  end

  private

  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end
end
