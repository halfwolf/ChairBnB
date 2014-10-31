class Api::ReservationsController < ApplicationController

  def  index
    @reservations = current_user.reservations
    render :index
  end
  
  def show
    @reservation = current_user.reservations.find(params[:id])
    render :show
  end
  
end