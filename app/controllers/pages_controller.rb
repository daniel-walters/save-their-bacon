class PagesController < ApplicationController
  #send user to their home page if they are already signed in - otherwise go to index
  before_action :redirect_signed_in_user, only: [:index]
  before_action :authenticate_user!, only: [:account]
  before_action :authorize_admin, only: [:admin, :admin_view_user, :admin_approve_user]

  def index
  end

  def home
  end

  def account
    @cur_user = User.eager_load(address: {state: :country}).find(current_user.id)
    if current_user.sanctuary?
      @user_animals = Animal.where(owner: current_user)
    else
      @user_animals = Sponsorship.where(sponsor: current_user).map {|s| s.animal}
    end
  end

  def contact
  end

  def admin
    @unapproved = User.where(approved: false)
  end

  def admin_view_user
  end

  def admin_approve_user
    User.find(params[:id]).update(approved: true)
    redirect_to admin_path, notice: "User Approved"
  end

  private

  def redirect_signed_in_user
    redirect_to user_home_path if user_signed_in?
  end

  def authorize_admin
    redirect_to root_path, notice: "You don't have access to admin pages." if !current_user.admin?
  end 
end
