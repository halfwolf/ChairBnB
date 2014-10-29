class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :author_id, presence: true
      t.integer :reservation_id, presence: true, unique: true
      t.string :title, presence: true
      t.text :body

      t.timestamps
    end
    
    add_index :reviews, :reservation_id, unique: true
  end
end
