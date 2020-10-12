class CreatePointHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :point_histories do |t|
      t.integer :customer_id, null: false
      t.integer :balance, null: false, default: 500
      t.integer :trigger_id, null: false

      t.timestamps
    end
  end
end
