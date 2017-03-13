class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :grade, limit: 10
      t.integer :score #total score, which determines grade when it falls in a range
      t.string :cuisine
      t.integer :zip_code, limit: 5
      t.string :phone
      t.string :address
      t.integer :neighborhood_id
      t.integer :camis #this is the API's unique identifier for their restaurants. We could swap to use it as our primary key as well, but it currently is not
    end
  end
end
