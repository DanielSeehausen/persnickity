class RestaurantViolation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :violation
end
