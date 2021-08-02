class User < ApplicationRecord
  before_create :set_approval

  belongs_to :address
  has_many :sponsorships, foreign_key: "sponsor_id", dependent: :destroy
  has_many :animals, foreign_key: "owner_id", dependent: :destroy

  accepts_nested_attributes_for :address

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum role: {
    sponsor: 0,
    sanctuary: 1,
    admin: 2
  }

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def get_simple_location
    "#{self.address.state.name}, #{self.address.state.country.name}"
  end

  private

  #set all sanctuary account to unaproved on creation
  def set_approval
    self.sanctuary? ? self.approved = false : self.approved = true
  end
end
