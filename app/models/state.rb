class State < ApplicationRecord
  before_save :find_or_create_country

  belongs_to :country
  has_many :addresses

  accepts_nested_attributes_for :country

  private

  def find_or_create_country
    self.country = Country.find_or_create_by(name: country.name)
  end

end
