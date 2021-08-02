class Animal < ApplicationRecord
  before_create :downcase_name
  belongs_to :category
  belongs_to :owner, foreign_key: "owner_id", class_name: "User"
  has_one :sponsorship
  has_one_attached :profile_picture
  has_many_attached :media

  private

  def downcase_name
    self.name = self.name.downcase
  end
end
