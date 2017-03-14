class Neighborhood < ApplicationRecord
  has_many :restaurants

  def get_most_common_cuisine
    cuisine_hash = Hash.new
    self.restaurants.select(:cuisine).each do |r|
      cuisine = r.cuisine
      cuisine_hash[cuisine] = Restaurant.where("cuisine = ?", cuisine).count
    end
    return cuisine_hash.key(cuisine_hash.values.max)
  end

  def get_dominance_of_grade(grade)
    return self.restaurants.where("grade = ?", grade).count.to_f / self.restaurants.count.to_f
  end

  def self.get_avg_peer_dominance_of_grade(grade, excl_neigh=nil)
    #returns a neighborhood's %of the AVERAGE of all peers (not the x'th percentile)
    dominance_percentiles = []
    Neighborhood.all.each do |n|
      next if n == excl_neigh
      grade_dominance = n.get_dominance_of_grade(grade)
      dominance_percentiles << grade_dominance unless grade_dominance.nan?
    end
    return dominance_percentiles.sum.to_f / dominance_percentiles.count.to_f
  end

  def get_relative_dominance_of_grade(grade)
    peer_grade_dominance_avg = Neighborhood.get_avg_peer_dominance_of_grade(grade, self)
    grade_dominance_avg = get_dominance_of_grade(grade)
    return grade_dominance_avg / peer_grade_dominance_avg
  end

  def self.get_random_dominance
    #returns a random neighborhood's %of the AVERAGE of all peers (not the x'th percentile)
    offset = rand(Neighborhood.count)
    neighborhood = Neighborhood.offset(offset).first
    grade = Restaurant.ACTIVE_GRADES.sample
    dominance = neighborhood.get_relative_dominance_of_grade(grade)
    return {:neighborhood => neighborhood,
            :grade        => grade,
            :dominance    => dominance}
  end

  def get_bottom_five
    #returns bottom 5 PERFORMING (highest scores) restaurants
    self.restaurants.all.order("score DESC").first(5)
  end

  def get_top_five
    #returns top 5 PERFORMING (lowest scores) restaurants
    self.restaurants.all.order("score ASC").first(5)
  end

  def self.get_worst_all_NYC
    Restaurant.all.order("score DESC").where.not(score: nil).first
  end

end
