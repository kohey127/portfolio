class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :service
  
  validates :content, presence: true, length: {maximum: 400}
end
