class Violation < ApplicationRecord
  has_many :restaurant_violations
  has_many :restaurants, through: :restaurant_violations
end
