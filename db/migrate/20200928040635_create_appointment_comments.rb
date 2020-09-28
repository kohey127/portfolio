class CreateAppointmentComments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_comments do |t|
      t.references :customer, index: false, foreign_key: true
      t.references :appointment, index: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
