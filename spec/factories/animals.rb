FactoryBot.define do
  factory :animal do
    name { "MyString" }
    year_born { 1 }
    weight { 1 }
    bio { "MyText" }
    species { "MyString" }
    sponsored { false }
    sponsor_price { 1 }
    category { nil }
    owner { nil }
  end
end
