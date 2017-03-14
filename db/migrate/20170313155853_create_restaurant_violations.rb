class CreateRestaurantViolations < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_violations do |t|
      t.integer :restaurant_id
      t.integer :violation_id
      #1999-01-08	(ISO 8601) format
      t.date :inspection_date
      t.integer :score

      t.timestamps
    end
  end
end
