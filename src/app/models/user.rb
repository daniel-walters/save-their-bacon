class User < ApplicationRecord
  before_create :set_approval
  before_create :capitalize_name

  belongs_to :address
  has_many :sponsorships, foreign_key: "sponsor_id", dependent: :destroy, inverse_of: "sponsor"
  has_many :animals, foreign_key: "owner_id", dependent: :destroy, inverse_of: "owner"

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

  def get_full_location
    "#{self.address.street_number} #{self.address.street_name}, #{self.address.suburb}, #{self.address.postcode}, #{self.address.state.name}, #{self.address.state.country.name}"
  end

  private

  #set all sanctuary account to unaproved on creation
  def set_approval
    self.sanctuary? ? self.approved = false : self.approved = true
  end

  def capitalize_name
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
  end
end
