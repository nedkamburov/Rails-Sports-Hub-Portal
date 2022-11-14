class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  validates :name, presence: true

  enum role: [:user, :admin]
  after_initialize :set_default_role, if: :new_record?

  has_one_attached :avatar
  has_many :comments
  has_many :likes
  has_many :dislikes

  def set_default_role
    self.role ||= :user
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
