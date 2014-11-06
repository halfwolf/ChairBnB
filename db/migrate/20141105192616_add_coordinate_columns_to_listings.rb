class AddCoordinateColumnsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :lon, :float 
    add_column :listings, :lat, :float
    
    add_index :listings, [:lon, :lat]
    
  end
end
