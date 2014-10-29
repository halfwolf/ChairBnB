class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end
  
  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      flash.now[:messages] = ["You have left a review!"]
      redirect_to listings_url
    else
      flash.now[:errors] = @review.errors.full_messages
      render :new
    end
  end  
  
  private
  
  def review_params

end
