class Dish < ApplicationRecord
  belongs_to :restaurant
  belongs_to :order
end
