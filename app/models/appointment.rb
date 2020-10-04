class Appointment < ApplicationRecord
  belongs_to :service
  belongs_to :to_customer, class_name:"Customer", foreign_key: :to_customer_id
  belongs_to :from_customer, class_name:"Customer", foreign_key: :from_customer_id
  has_one :appointment_comment
  has_many :exp_histories, dependent: :destroy
  
  validates :to_customer_id, presence: true
  validates :from_customer_id, presence: true
  validates :request_date, presence: true
  
  enum status:{ applying: 0, success: 1, failure: 2, done: 3 }

  enum request_format:{ online: 0, telephone: 1, message: 2, anything: 3 }
  
  def partner_customer(id)
    return self.to_customer if self.from_customer_id == id    
    self.from_customer
  end
end