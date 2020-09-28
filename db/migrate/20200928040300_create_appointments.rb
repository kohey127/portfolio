class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :customer, index: false, foreign_key: true
      t.references :service, index: false, foreign_key: true
      t.integer	:from_customer_id, null: false
      t.integer	:request_format, null: false
      t.integer	:request_date, null: false
      t.integer	:status, null: false

      t.timestamps
    end
  end
end
