class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :service
  
  validates :content, presence: true, length: {minimum: 1, maximum: 400}
end
