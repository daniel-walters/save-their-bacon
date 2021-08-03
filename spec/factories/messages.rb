FactoryBot.define do
  factory :message do
    chat { nil }
    sender { nil }
    body { "MyText" }
  end
end
