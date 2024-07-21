class SettingsController < ApplicationController
    before_action :authenticate_user!
  
    def view
      @user = current_user
    end
  
    def update_profile_picture
      @user = current_user
      if @user.update(user_params)
        redirect_to user_settings_path, notice: 'Profile picture updated successfully.'
      else
        render :view, alert: 'Failed to update profile picture.'
      end
    end
  
    def update_username
      @user = current_user
      if @user.update(user_params)
        redirect_to user_settings_path, notice: 'Username updated successfully.'
      else
        render :view, alert: 'Failed to update username.'
      end
    end
  
    def update_email
      @user = current_user
      if @user.update(user_params)
        redirect_to user_settings_path, notice: 'Email updated successfully.'
      else
        render :view, alert: 'Failed to update email.'
      end
    end
  
    def update_password
      @user = current_user
      if @user.update(user_params)
        bypass_sign_in(@user)
        redirect_to user_settings_path, notice: 'Password updated successfully.'
      else
        render :view, alert: 'Failed to update password.'
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:profile_picture, :username, :email, :password, :password_confirmation)
    end
  end
  