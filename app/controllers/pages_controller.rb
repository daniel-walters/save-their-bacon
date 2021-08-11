class PagesController < ApplicationController
  #send user to their home page if they are already signed in - otherwise go to index
  before_action :redirect_signed_in_user, only: [:index]
  before_action :authenticate_user!, only: [:account, :home, :admin, :admin_view_user, :admin_approve_user, :admin_deny_user]
  before_action :authorize_admin, only: [:admin, :admin_view_user, :admin_approve_user, :admin_deny_user]
  before_action :get_user, only: [:admin_approve_user, :admin_view_user, :admin_deny_user]
  
  def index
    #var used for styling
    @landing = true
  end

  def home
    #create random seed using the date to get constant 'daily featured animal' (assuming Animal.count stays constant)
    srand (Date.today.year + Date.today.month + Date.today.day)
    @featured_animal = Animal.find(rand(1..Animal.count))

    #get most recent 5 articles
    @articles = Article.last(5).reverse
  end

  def account
    if current_user&.sanctuary?
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
  end

  #approve user and redirect
  def admin_approve_user
    @user.update(approved: true)
    redirect_to admin_path, notice: "User Approved"
  end

  #delete user and redirect
  def admin_deny_user
    @user.destroy
    redirect_to admin_path, notice: "User Denied and Account Deleted"
  end

  private

  #redirect a user if they are signed in
  def redirect_signed_in_user
    redirect_to user_home_path if user_signed_in?
  end

  #redirect user if they arent an admin
  def authorize_admin
    redirect_to root_path, notice: "You don't have access to admin pages." if !current_user.admin?
  end 

  def get_user
    @user = User.find(params[:id])
  end
end
