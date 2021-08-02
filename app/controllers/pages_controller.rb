class PagesController < ApplicationController
  #send user to their home page if they are already signed in - otherwise go to index
  before_action :redirect_signed_in_user, only: [:index]
  before_action :authenticate_user!, only: [:account, :home, :admin, :admin_view_user, :admin_approve_user, :admin_deny_user]
  before_action :authorize_admin, only: [:admin, :admin_view_user, :admin_approve_user, :admin_deny_user]
  
  def index
    @landing = true
  end

  def home
    @featured_animal = Animal.all.sample
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
    @users = User.where(approved: true)
    @unapproved = User.where(approved: false)
  end

  def admin_view_user
    @user = User.find(params[:id])
  end

  def admin_approve_user
    User.find(params[:id]).update(approved: true)
    redirect_to admin_path, notice: "User Approved"
  end

  def admin_deny_user
    User.find(params[:id]).destroy
    redirect_to admin_path, notice: "User Denied and Account Deleted"
  end

  private

  def redirect_signed_in_user
    redirect_to user_home_path if user_signed_in?
  end

  def authorize_admin
    redirect_to root_path, notice: "You don't have access to admin pages." if !current_user.admin?
  end 
end
