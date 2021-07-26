class User < ApplicationRecord
  before_create :set_approval

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum role: {
    sponsor: 0,
    sanctuary: 1,
    admin: 2
  }

  private

  #set all sanctuary account to unaproved on creation
  def set_approval
    self.sanctuary? ? self.approved = false : self.approved = true
    #if !self.sanctuary?
      #puts "not a sanctuary"
      #self.approved = true
      #puts "approved: #{self.approved?}"
    #end
  end
end
