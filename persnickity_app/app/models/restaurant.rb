class Restaurant < ApplicationRecord
  has_many :restaurant_violations

  def unhealth_score
    self.restaurant_violations.inject(0){|sum, x| sum += x.score}
  end

  def self.best_five_health_score
    Restaurant.all.sort_by{|r| r.unhealth_score}.first(5)
  end

  def self.worst_five_health_score
    Restaurant.all.sort_by{|r| r.unhealth_score}.last(5)
  end

end
