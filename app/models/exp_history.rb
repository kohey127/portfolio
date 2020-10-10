class ExpHistory < ApplicationRecord
  belongs_to :customer
  belongs_to :trigger, class_name:"Customer", foreign_key: :trigger

  validates :balance, presence: true
  validates :trigger, presence: true
end
