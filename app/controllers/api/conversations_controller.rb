class Api::ConversationsController < ApplicationController
  

  def  index
    @conversations = current_user.conversations
    render :index
  end
  
  
  def show
    @conversation = current_user.messages_with(params[:id])
    render :show
  end
  
end