class RemoveLocationAddOtherAttributesToListings < ActiveRecord::Migration
  def change
    
    remove_column :listings, :location, :string
    
    add_column :listings, :room_type, :string, presence: true
    add_column :listings, :chair_type, :string, presence: true
    add_column :listings, :street, :string
    add_column :listings, :city, :string
    add_column :listings, :zip_code, :integer, presence: true
    add_column :listings, :seats, :integer, presence: true, precision: 9
    
    add_index :listings, :zip_code
    add_index :listings, :chair_type
    add_index :listings, :room_type
    add_index :listings, :seats
  end
end
