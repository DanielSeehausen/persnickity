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
    dominance_percentiles = [] #return avg not array
    Neighborhood.all.each do |n|
      next if n == excl_neigh
      dominance_percentiles << n.get_dominance_of_grade(grade)
      puts dominance_percentiles
    end
    return dominance_percentiles.sum.to_f / dominance_percentiles.count.to_f
  end

  def get_relative_dominance_of_grade(grade)
    peer_grade_dominance_avg = Neighborhood.get_avg_peer_dominance_of_grade(grade, self)
    grade_dominance_avg = get_dominance_of_grade(grade)
    return grade_dominance_avg / peer_grade_dominance_avg
  end

end
