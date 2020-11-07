class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :service
  
  validates :content, presence: true
  has_many :notifications, dependent: :destroy
  
end
