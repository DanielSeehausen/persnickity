class CreateViolations < ActiveRecord::Migration[5.0]
  def change
    create_table :violations do |t|
      t.string :code
      t.string :description
      #TODO this should be date/time and the rake task should be changed accordingly to get it into postgres format
      t.string :inspection_date
      t.integer :score
      t.boolean :critical_flag
    end
  end
end
