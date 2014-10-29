require 'rails_helper'

RSpec.describe Review, :type => :model do


  it "requires a reservation" do
    no_res_review = Review.create({
      author_id: 1,
      title: "it was güd"
    })
    expect(no_res_review.errors[:reservation_id]).to include("can't be blank")
  end
  
  it "requires a title" do
    no_title_review = Review.create({
      author_id: 1,
      reservation_id: 1
    })
    expect(no_title_review.errors[:title]).to include("can't be blank")
  end
  
  it "won't allow multiple reviews for the same reservation" do
    res_review = Review.create({
      author_id: 1,
      reservation_id: 1,
      title: "it was güd"
    })
    res_review_two = Review.create({
      author_id: 1,
      reservation_id: 1,
      title: "it was güd"
    })
    expect(res_review_two.errors[:reservation_id][0]).to include("been taken")
  end
  
  
end
