class Restaurant < ApplicationRecord
  has_many :violations
  validates :zip_code, presence: true
  after_create :assign_neighborhood_id_from_zip

  def assign_neighborhood_id_from_zip

  end

  def self.ACTIVE_GRADES
    ['A', 'B', 'C']
  end


end
