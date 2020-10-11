class CreateExpHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :exp_histories do |t|
      t.integer :customer_id, null: false
      t.integer :balance, null: false, default: 0
      t.integer :trigger_id, null: false

      t.timestamps
    end
  end
end
