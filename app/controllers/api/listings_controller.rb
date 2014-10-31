class Api::ListingsController < ApplicationController

  def  index
    @listings = current_user.listings
    render :index
  end
  
  def show
    @listing = Listing.find(params[:id])
    render :show
  end

end