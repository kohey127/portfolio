class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :customer_id, null: false
      t.integer :service_id, null: false
      t.integer	:from_customer_id, null: false
      t.integer	:request_format, null: false
      t.integer	:request_date, null: false
      t.integer	:status, null: false

      t.timestamps
    end
  end
end
