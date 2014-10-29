class ReservationsController < ApplicationController

  before_action :require_user!


  def create
    @reservation = current_user.reservations.new(reservation_params)
    unless @reservation.save
      flash.now[:errors] = @reservation.errors.full_messages
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
    params.require(:reservation).permit(:chair_id, :start, :end)
  end

end
