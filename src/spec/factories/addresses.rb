FactoryBot.define do
  factory :address do
    street_number { 1 }
    street_name { "MyString" }
    postcode { "MyString" }
    suburb { "MyString" }
    state { nil }
  end
end
