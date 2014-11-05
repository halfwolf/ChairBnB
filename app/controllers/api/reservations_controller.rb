class Api::ReservationsController < ApplicationController

  def  index
    @reservations = current_user.reservations
    render :index
  end
  
  def show
    @reservation = current_user.reservations.find(params[:id])
    render :show
  end
  
  def create
    @reservation = current_user.reservations.new(reservation_params)
    @reservation.price = Listing.find(params[:reservation][:chair_id]).price
    if @reservation.save
      render :json => @reservation
    else
      render :json => @reservation.errors, :status => :unprocessable_entity
    end    
  end
  
  private 
  
  def reservation_params
    params.require(:reservation).permit(:chair_id, :start_date, :end_date)
  end
  
end