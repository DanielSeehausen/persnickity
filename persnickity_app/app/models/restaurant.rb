class Restaurant < ApplicationRecord
  belongs_to :neighborhood
  has_many :violations
end
