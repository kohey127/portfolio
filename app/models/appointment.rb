class Appointment < ApplicationRecord
  belongs_to :service
  has_many :appointment_comments, dependent: :destroy
  has_many :exp_histories, dependent: :destroy
  
  validates :to_customer_id, presence: true
  validates :from_customer_id, presence: true
  validates :request_date, presence: true
  
  scope :success, -> {where("from_customer_id = ? OR to_customer_id = ?", 'current_customer.id', 'current_customer.id').where(Appointment.where(status: "success"))
  # Ex:- scope :active, -> {where(:active => true)}

  enum status:{ applying: 0, success: 1, failure: 2, done: 3 }

  enum request_format:{ online: 0, telephone: 1, message: 2, anything: 3 }
end