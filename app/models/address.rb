class Address < ApplicationRecord
  belongs_to :state
  has_many :users

  accepts_nested_attributes_for :state
end
