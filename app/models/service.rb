class Service < ApplicationRecord
  belongs_to :customer
  has_many :appointments, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :catchphrase, presence: true
  validates :place, presence: true
  validates :content, presence: true
  validates :point, presence: true
  
  attachment :image
  
  enum format:{ face_to_face: 0, online: 1, telephone: 2, message: 3 }
  validates :format, inclusion: { in: Service.formats.keys }

end