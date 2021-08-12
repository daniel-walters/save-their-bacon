require 'rails_helper'

RSpec.describe "animals/edit", type: :view do
  before(:each) do
    @animal = assign(:animal, Animal.create!(
      name: "MyString",
      year_born: 1,
      weight: 1,
      bio: "MyText",
      species: "MyString",
      sponsored: false,
      sponsor_price: 1,
      category: nil,
      owner: nil
    ))
  end

  it "renders the edit animal form" do
    render

    assert_select "form[action=?][method=?]", animal_path(@animal), "post" do

      assert_select "input[name=?]", "animal[name]"

      assert_select "input[name=?]", "animal[year_born]"

      assert_select "input[name=?]", "animal[weight]"

      assert_select "textarea[name=?]", "animal[bio]"

      assert_select "input[name=?]", "animal[species]"

      assert_select "input[name=?]", "animal[sponsored]"

      assert_select "input[name=?]", "animal[sponsor_price]"

      assert_select "input[name=?]", "animal[category_id]"

      assert_select "input[name=?]", "animal[owner_id]"
    end
  end
end
