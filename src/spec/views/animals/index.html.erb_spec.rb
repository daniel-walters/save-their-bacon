require 'rails_helper'

RSpec.describe "animals/index", type: :view do
  before(:each) do
    assign(:animals, [
      Animal.create!(
        name: "Name",
        year_born: 2,
        weight: 3,
        bio: "MyText",
        species: "Species",
        sponsored: false,
        sponsor_price: 4,
        category: nil,
        owner: nil
      ),
      Animal.create!(
        name: "Name",
        year_born: 2,
        weight: 3,
        bio: "MyText",
        species: "Species",
        sponsored: false,
        sponsor_price: 4,
        category: nil,
        owner: nil
      )
    ])
  end

  it "renders a list of animals" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Species".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
