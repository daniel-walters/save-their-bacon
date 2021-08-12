require 'rails_helper'

RSpec.describe "animals/show", type: :view do
  before(:each) do
    @animal = assign(:animal, Animal.create!(
      name: "Name",
      year_born: 2,
      weight: 3,
      bio: "MyText",
      species: "Species",
      sponsored: false,
      sponsor_price: 4,
      category: nil,
      owner: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Species/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
