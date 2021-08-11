class State < ApplicationRecord
  before_save :check_if_country_exists
  before_create :capitalize_name

  belongs_to :country
  has_many :addresses

  accepts_nested_attributes_for :country

  private
  #use country already in db if duplicate
  def check_if_country_exists
    self.country = Country.find_by(name: country.name) if !Country.find_by(name: country.name).nil?
  end

  def capitalize_name
    self.name = self.name.capitalize
  end

end
