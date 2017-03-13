class CreateRestaurantViolations < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_violations do |t|
      t.string :inspection_type
      t.string :inspection_date
      t.integer :score
      t.integer :restaurant_id
      t.integer :violation_id
      t.timestamps
    end
  end
end
