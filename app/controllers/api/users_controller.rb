class Api::DashboardController < ApplicationController
  def dashboard
    render :json => current_user, include: [
        :listings, :reservations, 
        :sent_messages, :received_messages,
        :received_reviews]
  end
  
  
end