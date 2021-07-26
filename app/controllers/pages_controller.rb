class PagesController < ApplicationController
  #send user to their home page if they are already signed in - otherwise go to index
  before_action :redirect_signed_in_user, only: [:index]

  def index
  end

  def home
  end

  def account
  end

  def contact
  end

  private

  def redirect_signed_in_user
    redirect_to user_home_path if user_signed_in?
  end
end
