class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :grade, limit: 10
      t.string :cuisine
      t.integer :zip_code, limit: 5
      t.string :phone
      t.string :address
      t.integer :neighborhood_id
    end
  end
end
