class Service < ApplicationRecord
  belongs_to :customer
  has_many :appointments, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :catchphrase, presence: true
  validates :place, presence: true
  validates :content, presence: true
  validates :point, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  
  attachment :image
  
  enum format:{ face_to_face: 0, online: 1, telephone: 2, message: 3 }
  validates :format, inclusion: { in: Service.formats.keys }
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  def Service.search(search, word)
    target = Service.where(is_active: true)
		if search == "forward"
			target.where("catchphrase LIKE?", "#{word}%")
		elsif search == "backward"
			target.where("catchphrase LIKE?", "%#{word}")
		elsif search == "perfect"
			target.where("catchphrase LIKE?", "#{word}")
		elsif search == "partial"
			target.where("catchphrase LIKE?", "%#{word}%")
		else
			target.all
		end
	end
end