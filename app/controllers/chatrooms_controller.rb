# app/controllers/chatrooms_controller.rb
class ChatroomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chatrooms = Chatroom.all
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages
    @message = Message.new
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      redirect_to @chatroom
    else
      render :new
    end
  end

  def search
    @chatrooms = Chatroom.where('name LIKE ?', "%#{params[:query]}%")
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
