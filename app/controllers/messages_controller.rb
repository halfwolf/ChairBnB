class MessagesController < ApplicationController
  
  def new
    @message = Message.new
  end
  
  def create
    @message = current_user.sent_messages.new(message_params)
    if @message.save
      flash.now[:messages] = ["Message sent!"]
      redirect_to dashboard_url
    else
      flash.now[:errors] = @message.errors.full_messages
      render :new
    end
  end
  
  def show
    @message = Message.find(params[:id])
  end

  private 
  
  def message_params
    params.require(:message).permit(:subject, :body, :receiver_id)
  end

end
