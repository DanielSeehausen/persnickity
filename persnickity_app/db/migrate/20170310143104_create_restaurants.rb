class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.varchar{10} :grade
      t.integer :zip, limit: 5

      t.timestamps
    end
  end
end
