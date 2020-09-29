class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :customer, null: false
      t.integer :service, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
