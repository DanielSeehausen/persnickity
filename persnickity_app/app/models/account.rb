class Account < ApplicationRecord
  has_secure_password
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :user_name, presence: true, uniqueness: true
  validates :zip_code, presence: true
  has_one :neighborhood
  after_create :assign_neighborhood_id_from_zip

  def assign_neighborhood_id_from_zip

  end


end
