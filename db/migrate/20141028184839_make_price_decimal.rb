class MakePriceDecimal < ActiveRecord::Migration
  def change

    remove_column :listings, :price, :integer
    add_column :listings, :price, :decimal

  end
end
