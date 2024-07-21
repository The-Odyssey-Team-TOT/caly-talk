class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = current_user
      @posts = @user.posts
      @media_items = @user.media_items
    end
  end
  