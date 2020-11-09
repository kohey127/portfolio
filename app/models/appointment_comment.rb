class AppointmentComment < ApplicationRecord
  belongs_to :appointment
  belongs_to :customer
  validates :content, presence: true, length: {minimum: 1, maximum: 400}
end
