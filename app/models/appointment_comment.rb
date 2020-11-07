class AppointmentComment < ApplicationRecord
  belongs_to :appointment
  belongs_to :customer
  validates :content, presence: true

  has_many :notifications, dependent: :destroy

  def create_notification_chat!(current_customer, appontment_id, appointment_comment_id)
    appointment = Appointment.find(id: appontment_id)
    notification = current_customer.active_notifications.new (
      appointment_comment_id: self.id
      visited_id: self.partner_customer(current_customer.id)
      action: "chat"
    )
    notification.save if notification.valid?
  end

end
