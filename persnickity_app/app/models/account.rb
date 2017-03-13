class Account < ApplicationRecord
  has_secure_password
  has_one :neighborhood

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :user_name, presence: true, uniqueness: true

  after_create :assign_neighborhood_id_from_zip

  def assign_neighborhood_id_from_zip

  end


end
