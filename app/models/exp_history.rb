class ExpHistory < ApplicationRecord
  belongs_to: customer

  validates :balance, presence: true
  validates :trigger, presence: true
end
