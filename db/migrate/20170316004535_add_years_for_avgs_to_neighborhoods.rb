class AddYearsForAvgsToNeighborhoods < ActiveRecord::Migration[5.0]
  def change
    add_column :neighborhoods, :years_for_avgs, :string
  end
end
