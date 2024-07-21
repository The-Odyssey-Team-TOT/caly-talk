class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, only: [:show, :destroy]
  before_action :authorize_user!, only: [:destroy]

  def index
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.new
    @current_chatroom = Chatroom.find_by(id: params[:current_chatroom_id])
    @message = Message.new
  end

  def show
    @chatrooms = Chatroom.all
    @current_chatroom = @chatroom
    @messages = @chatroom.messages
    @message = Message.new
    render :index
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    @chatroom.user = current_user
    if @chatroom.save
      redirect_to @chatroom
    else
      @chatrooms = Chatroom.all
      @current_chatroom = Chatroom.find_by(id: params[:current_chatroom_id])
      render :index
    end
  end

  def destroy
    @chatroom.destroy
    redirect_to chatrooms_path
  end

  def search
    @chatrooms = Chatroom.where('name LIKE ?', "%#{params[:query]}%")
    @chatroom = Chatroom.new
    @current_chatroom = Chatroom.find_by(id: params[:current_chatroom_id])
    render :index
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end

  def authorize_user!
    redirect_to chatrooms_path, alert: "Not authorized" unless @chatroom.owned_by?(current_user)
  end
end
