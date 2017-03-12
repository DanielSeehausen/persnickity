class CreateViolations < ActiveRecord::Migration[5.0]
  def change
    create_table :violations do |t|
      t.string :code
      t.string :description
      t.string :critial_flag
      t.integer :score
      t.string :inspection_type
      t.string :inspection_date
      t.integer :restaurant_id
    end
  end
end
