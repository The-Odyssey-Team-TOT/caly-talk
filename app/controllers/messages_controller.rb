class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom
  before_action :set_message, only: [:destroy]
  before_action :authorize_user!, only: [:destroy]

  def create
    @message = @chatroom.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to @chatroom
    else
      @chatrooms = Chatroom.all
      @current_chatroom = @chatroom
      @messages = @chatroom.messages
      render 'chatrooms/index'
    end
  end

  def destroy
    @message.destroy
    redirect_to @chatroom
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def set_message
    @message = @chatroom.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def authorize_user!
    unless @message.owned_by?(current_user) || @chatroom.owned_by?(current_user)
      redirect_to @chatroom, alert: "Not authorized"
    end
  end
end
