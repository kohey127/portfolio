class AppointmentComment < ApplicationRecord
  belongs_to :appointment
  belongs_to :customer
end
