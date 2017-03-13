class CreateNeighborhoods < ActiveRecord::Migration[5.0]
  def change
    create_table :neighborhoods do |t|
      t.string :name
      t.string :dominant_cuisine
      t.timestamps
    end
  end
end
