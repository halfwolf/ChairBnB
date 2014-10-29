class ReservationsController < ApplicationController

  before_action :require_user!
  
  before_action :require_owner, only: [:approve, :deny]
  
  def approve
    @reservation = Reservation.find(params[:id])
    @reservation.approve!
    redirect_to listing_url(@reservation.chair)
  end
  
  def deny
    @reservation = Reservation.find(params[:id])
    @reservation.deny!
    redirect_to listing_url(@reservation.chair)
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)
    unless @reservation.save
      flash.now[:errors] = @reservation.errors.full_messages
    else
      flash.now[:errors] = [  "reservation placed!"]
    end
    redirect_to listing_url(@reservation.chair_id)
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    if @reservation.destroy
      redirect_to listings_url
    else
      flash.now[:errors] = @reservation.errors.full_messages
      redirect_to redirect_to listing_url(@reservation.chair_id)
    end
  end
  
  def index
    @reservations = Listing.find(params[:listing_id]).reservations
  end

  private
  def reservation_params
    params.require(:reservation).permit(:chair_id, :start_date, :end_date)
  end
  
  def require_owner
    chair = Reservation.find(params[:id]).chair
    unless current_user.listings.include?(chair)
      flash.now[:errors] = ["You don't own that chair"]
      redirect_to listing_url(chair)
    end
  end
end
