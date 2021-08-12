class Address < ApplicationRecord
  before_save :check_if_state_exists

  validates :postcode, numericality: true
  validates :street_number, numericality: true

  belongs_to :state
  has_many :users

  accepts_nested_attributes_for :state

  private

  #use a state already in db if duplicate
  def check_if_state_exists
    self.state = State.find_by(name: state.name) if !State.find_by(name: state.name).nil?
  end 
end
