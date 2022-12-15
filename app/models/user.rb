class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  validates :name, presence: true

  enum role: [:user, :admin]
  after_initialize :set_default_role, if: :new_record?
  after_create :set_default_avatar

  has_one_attached :avatar
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy

  def set_default_role
    self.role ||= :user
  end

  def set_default_avatar
    if self.avatar.present?
      return
    end

    random_avatar = Faker::Avatar.image
    self.avatar.attach(io: URI.open(random_avatar), filename: "#{self.first_name}_#{self.last_name}_user_avatar")
  end
  
  def first_name
    self.name.split.first
  end

  def last_name
    self.name.split.last
  end

  def self.from_omniauth(auth)
    auth_name = auth.info.name
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid, name: auth.info.name, email: auth.info.email, password: Devise.friendly_token[0, 20])
    user.avatar.attach(io: URI.open(auth.info.image), filename: "#{auth_name.split.first}_#{auth_name.split.last}_user_avatar")

    user
  end
end
