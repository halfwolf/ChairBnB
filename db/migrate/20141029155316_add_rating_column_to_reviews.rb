class AddRatingColumnToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :rating, :integer, limit: 1, presence: true
  end
end
