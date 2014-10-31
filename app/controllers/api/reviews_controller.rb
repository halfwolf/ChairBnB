class Api::ReviewsController < ApplicationController

  def  index
    @reviews = current_user.all_reviews
    render :index
  end
  
  def show
    @review = current_user.all_reviews.find(params[:id])
    render :show
  end
  
  def create
    @review = current_user.all_reviews.new(review_params)
    if @review.save
      render :show
    else
      render :json => @review.errors, :status => :unprocessable_entity
    end
  end
  
  private 
  
  def review_params
    params.require(:review).permit(:title, :body, :rating)
  end
  
end