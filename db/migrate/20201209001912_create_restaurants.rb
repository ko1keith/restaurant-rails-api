class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string "name", nullable: false
      t.string "address", nullable: false
      
      t.timestamps
    end
  end
end
