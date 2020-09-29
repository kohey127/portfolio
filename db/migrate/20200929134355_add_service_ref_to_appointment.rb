class AddServiceRefToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointments, :service, foreign_key: true, index: false
  end
end
