class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :pre_home]

  def pre_home
  end
end
