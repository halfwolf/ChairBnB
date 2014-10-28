class MakePriceDecimalAndAddScale < ActiveRecord::Migration
  def change

    remove_column :listings, :price, :integer
    add_column :listings, :price, :decimal, scale: 2, precision: 6

  end
end
