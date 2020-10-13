class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.integer :customer_id, null: false
      t.text	:content, null: false
      t.string	:place, null: false
      t.string	:catchphrase, null: false
      t.string	:image_id
      t.integer :point, null: false
      t.boolean	:is_active, null: false, default: true      
      t.integer	:format, null: false
      
      t.timestamps
    end
  end
end