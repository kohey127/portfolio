class Service < ApplicationRecord
  belongs_to :customer
  has_many :appointments, dependent: :destroy
  has_many :comments, dependent: :destroy
end
