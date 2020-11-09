class Service < ApplicationRecord
  belongs_to :customer
  has_many :appointments, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :catchphrase, presence: true, length: {minimum: 1, maximum: 20}
  validates :place, presence: true, length: {minimum: 1, maximum: 20}
  validates :content, presence: true, length: {minimum: 1, maximum: 400}
  validates :point, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 200 }
  
  attachment :image
  
  enum format:{ face_to_face: 0, online: 1, telephone: 2, message: 3 }
  validates :format, inclusion: { in: Service.formats.keys }
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  def Service.search(word)
    target = Service.where(is_active: true)
    target.where("catchphrase LIKE?", "%#{word}%")
	end
end