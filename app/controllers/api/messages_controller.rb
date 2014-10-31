class Api::MessagesController < ApplicationController


  def  index
    @messages = current_user.all_messages
    render :index
  end
  
  def show
    @message = current_user.all_messages.find(params[:id])
    render :show
  end
  
  def create
    @message = current_user.all_messages.new(message_params)
    if @message.save
      render :show
    else
      render :json => @message.errors, :status => :unprocessable_entity
    end
  end
  
  private 
  
  def message_params
    params.require(:message).permit(:subject, :body, :receiver_id)
  end
  
end