class CreateBuses < ActiveRecord::Migration[7.0]
  def change
    create_table :buses do |t|
      t.string :name
      t.string :number
      t.string :company
      t.integer :price
      t.integer :seats
      t.integer :route_id
      t.string :starting_city
      t.string :destination_city
      t.datetime :departure_time

      t.timestamps
    end
  end
end
