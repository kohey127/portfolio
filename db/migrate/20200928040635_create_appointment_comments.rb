class CreateAppointmentComments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_comments do |t|
      t.integer :customer_id, null: false
      t.integer :appointment_id, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
