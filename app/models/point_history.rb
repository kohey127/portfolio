class PointHistory < ApplicationRecord
  belongs_to :customer
  belongs_to :trigger, class_name:"Customer", foreign_key: :customer_id
  
  validates :balance, presence: true
  validates :trigger, presence: true
end
