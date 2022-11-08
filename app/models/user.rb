class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  enum role: [:user, :admin]
  after_initialize :set_default_role, if: :new_record?

  has_one_attached :avatar
  has_many :comments
  has_many :likes

  def set_default_role
    self.role ||= :user
  end
  
  def first_name
    self.name.split.first
  end

  def last_name
    self.name.split.last
  end
end
