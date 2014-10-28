class ListingsController < ApplicationController

  before_action :require_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to listing_url(@listing)
    else
      flash.now[:errors] = @listing.errors.full_messages
      render :new
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = current_user.listings.find(params[:id])
    if @listing.update(listing_params)
      redirect_to listing_url(@listing)
    else
      flash.now[:errors] = @listing.errors.full_messages
      render :edit
    end
  end

  def destroy
    @listing = current_user.listings.find(params[:id])
    if @listing.destroy
      redirect_to listings_url
    else
      flash.now[:errors] = @listing.errors.full_messages
      render :show
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :description, :location, :price)
  end

end
