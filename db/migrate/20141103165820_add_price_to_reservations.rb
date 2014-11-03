class AddPriceToReservations < ActiveRecord::Migration

  def change
    add_column :reservations, :price, :decimal, scale: 2, precision: 6
  end
end
