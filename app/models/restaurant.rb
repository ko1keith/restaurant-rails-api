class Restaurant < ApplicationRecord
  has_many :orders
  has_many :dishes
  belongs_to :account
end
