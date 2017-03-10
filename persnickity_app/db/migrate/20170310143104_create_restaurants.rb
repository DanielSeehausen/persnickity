class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :grade, limit: 10
      t.integer :zip, limit: 5

      t.timestamps
    end
  end
end
