class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.references :customer, index: false, foreign_key: true
      t.string	:content, null: false
      t.string	:place, null: false
      t.string	:catchphrase, null: false
      t.string	:image_id, null: false
      t.boolean	:is_active, null: false, default: true      
      t.integer	:format, null: false
      
      t.timestamps
    end
  end
end
