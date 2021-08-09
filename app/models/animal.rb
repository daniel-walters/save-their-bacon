class Animal < ApplicationRecord
  before_create :capitalize_name
  belongs_to :category
  belongs_to :owner, foreign_key: "owner_id", class_name: "User"
  has_one :sponsorship
  has_one_attached :profile_picture
  has_many_attached :media

  def get_age
    Time.now.year - self.year_born
  end 

  private

  def capitalize_name
    self.name = self.name.capitalize
  end
end
