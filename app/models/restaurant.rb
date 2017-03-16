class Restaurant < ApplicationRecord
  has_many :restaurant_violations
  has_many :violations, through: :restaurant_violations
  belongs_to :neighborhood
  validates :zip_code, presence: true

  #TODO
  # after_create :assign_neighborhood_id_from_zip
  #
  # def assign_neighborhood_id_from_zip
  #
  # end

  def self.ACTIVE_GRADES
    ['A', 'B', 'C']
  end

  def self.search(search)
    where("name ILIKE ? OR cuisine ILIKE ?", "%#{search}%", "%#{search}%")
  end

end
