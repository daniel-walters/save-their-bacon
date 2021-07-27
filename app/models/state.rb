class State < ApplicationRecord
  belongs_to :country
  has_many :addresses

  accepts_nested_attributes_for :country
end
