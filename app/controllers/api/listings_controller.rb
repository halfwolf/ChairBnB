class Api::ListingsController < ApplicationController

  wrap_parameters false

  def index
    @listings = Listing.bounded_listings(params)
    render :index
  end
  
  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      
      
      picture_params = params[:listing][:pic] ? pic_params : nil
      @pic = Picture.new(picture_params)
      @pic.listing_id = @listing.id
      @pic.save

      render json: @listing
    else
      render json: @listing.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def myListings
    @listings = current_user.listings
    render :myListings
  end
  
  def show
    @listing = Listing.find(params[:id])
    render :show
  end
  
  private
  
  
  def listing_params
    params.require(:listing).permit(:room_type, :chair_type, :seats, 
      :street, :city, :zip_code, :name, :description, :price)
  end
  
  def pic_params
    params.require(:listing).permit(:pic)
  end
  

end