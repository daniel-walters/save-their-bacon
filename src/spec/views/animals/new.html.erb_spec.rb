require 'rails_helper'

RSpec.describe "animals/new", type: :view do
  before(:each) do
    assign(:animal, Animal.new(
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

  it "renders new animal form" do
    render

    assert_select "form[action=?][method=?]", animals_path, "post" do

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
