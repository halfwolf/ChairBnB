class Api::ListingsController < ApplicationController

  def index
    @listings = Listing.all
    render :index
  end
  
  def myListings
    @listings = current_user.listings
    render :myListings
  end
  
  def show
    @listing = Listing.find(params[:id])
    render :show
  end

end