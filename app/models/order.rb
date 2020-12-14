class Order < ApplicationRecord
  belongs_to :restaurant
  belongs_to :account

  before_save :calculate_price

  def calculate_price
    self.price = Dish.where(id: JSON.parse(dish_ids).keys.map(&:to_i)).pluck(:price).inject(:+)
  end
end
