class Appointment < ApplicationRecord
  belongs_to :customer
  belongs_to :service
  has_many :appointment_comments, dependent: :destroy
  has_many :exp_histories, dependent: :destroy
  
  validates :customer_id, presence: true
  validates :service_id, presence: true
  validates :from_customer_id, presence: true
  validates :request_date, presence: true
  enum status:{ applying: 0, success: 1, failure: 2, done: 3 }
  validates :format, inclusion: { in: Appointment.statuses.keys }

  enum request_format:{ online: 0, telephone: 1, message: 2, anything: 3 }
  validates :request_format, inclusion: { in: Appointment.request_formats.keys }
end