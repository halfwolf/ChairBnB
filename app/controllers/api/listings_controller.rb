class Api::ListingsController < ApplicationController

  wrap_parameters false

  def index
    sort = { 
      "rating DESC" => "rating DESC",
      "price DESC" => "price DESC",
      "price ASC" => "price ASC"
    }
    sort_params = sort[params[:sort]] || "rating DESC"
    
    if sort_params == "rating DESC"
      listings_with_reviews = Listing.bounded_listings(params)
        .select("listings.*")
        .joins("LEFT OUTER JOIN reservations on reservations.chair_id = listings.id")
        .joins("LEFT OUTER JOIN reviews on reviews.reservation_id = reservations.id")
        .group("listings.id")
        .order("CASE SUM(reviews.rating)
                  WHEN 0 THEN 0
                  ELSE AVG(reviews.rating)
                END")
       @listings = listings_with_reviews.page(params[:page]).per(5)
    else
    
    @listings = Listing.bounded_listings(params).order(sort_params).page(params[:page]).per(5)
  end
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