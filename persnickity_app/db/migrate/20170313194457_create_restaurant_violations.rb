class CreateRestaurantViolations < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_violations do |t|
      t.integer :violation_id
      t.integer :restaurant_id
      t.string :inspection_date
      t.string :critical_flag
      t.timestamps
    end
  end
end
