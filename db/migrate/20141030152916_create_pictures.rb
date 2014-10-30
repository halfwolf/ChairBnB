class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :listing_id, presence: true
      t.integer :ord, default: 1

      t.timestamps
    end
  end
end
