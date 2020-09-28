class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :appointments, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :appointment_comments, dependent: :destroy
  has_many :customer_genres, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  scope :only_active, -> { where(is_active: true) }
  
  attachment :image
end
