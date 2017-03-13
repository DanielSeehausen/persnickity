class CreateRestaurantViolations < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_violations do |t|
      t.integer :restaurant_id
      t.integer :violation_id
      t.boolean :critical_flag
      t.integer :score
      t.string :inspection_date

      t.timestamps
    end
  end
end
