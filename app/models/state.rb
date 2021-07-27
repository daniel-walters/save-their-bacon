class State < ApplicationRecord
  before_save :check_if_country_exists

  belongs_to :country
  has_many :addresses

  accepts_nested_attributes_for :country

  private

  def check_if_country_exists
    self.country = Country.find_by(name: country.name) if !Country.find_by(name: country.name).nil?
  end

end
