class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :pre_home]

  def home
  end

  def pre_home
  end
end
