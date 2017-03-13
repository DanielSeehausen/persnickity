class CreateViolations < ActiveRecord::Migration[5.0]
  def change
    create_table :violations do |t|
      t.string :code
      t.string :description
      t.string :critial_flag
    end
  end
end
