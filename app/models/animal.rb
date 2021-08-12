class Animal < ApplicationRecord
  before_create :capitalize_name
  belongs_to :category
  belongs_to :owner, foreign_key: "owner_id", class_name: "User"
  has_one :sponsorship
  has_one_attached :profile_picture
  has_many_attached :media

  validates :name, presence: true
  validates :year_born, numericality: {only_integer: true}, presence: true
  validates :weight, numericality: true, presence: true
  validates :bio, presence: true
  validates :species, presence: true
  validates :sponsor_price, presence: true, numericality: true

  def get_age
    Time.now.year - self.year_born
  end 

  private

  def capitalize_name
    self.name = self.name.capitalize
  end
end
