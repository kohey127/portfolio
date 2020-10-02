class Appointment < ApplicationRecord
  belongs_to :customer
  belongs_to :service
  has_many :appointment_comments, dependent: :destroy
  has_many :exp_histories, dependent: :destroy  
end
