class Address < ApplicationRecord
  before_save :find_or_create_state
  
  belongs_to :state
  has_many :users

  accepts_nested_attributes_for :state

  private

  def find_or_create_state
    self.state = State.find_or_create_by(name: state.name)
  end
end
