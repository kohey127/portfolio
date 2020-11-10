class AppointmentComment < ApplicationRecord
  belongs_to :appointment
  belongs_to :customer
  validates :content, presence: true, length: {maximum: 400}
end
