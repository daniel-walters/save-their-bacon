class Animal < ApplicationRecord
  belongs_to :category
  belongs_to :owner, foreign_key: "owner_id", class_name: "User"
  has_one :sponsorship
end