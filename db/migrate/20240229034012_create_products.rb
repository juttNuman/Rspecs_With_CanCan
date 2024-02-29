class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
