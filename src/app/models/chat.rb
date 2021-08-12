class Chat < ApplicationRecord
  belongs_to :sponsorship
  has_many :messages
end
