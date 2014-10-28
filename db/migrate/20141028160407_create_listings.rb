class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name, presence: true
      t.text :description
      t.string :location
      t.integer :owner_id
      t.integer :price

      t.timestamps
    end
  end
end
