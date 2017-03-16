class AddAvgScoreOverTimeToNeighborhoods < ActiveRecord::Migration[5.0]
  def change
    add_column :neighborhoods, :avg_yearly_scores, :string
  end
end
