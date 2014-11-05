class Api::MessagesController < ApplicationController


  def  index
    @messages = current_user.all_messages
    render :json => @messages
  end
  
  def show
    @message = current_user.all_messages.find(params[:id])
    render :json => @message
  end
  
  def create
    @message = current_user.sent_messages.new(message_params)
    if @message.save
      render :json => @message
    else
      render :json => @message.errors, :status => :unprocessable_entity
    end
  end
  
  private 
  
  def message_params
    params.require(:message).permit(:subject, :body, :receiver_id)
  end
  
end