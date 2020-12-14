class Account < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email
  has_one :restaurant
end
