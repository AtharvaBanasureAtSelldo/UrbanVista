FactoryBot.define do
  factory :customer do
    tenant { FactoryBot.create(:tenant) }
    name { "Test Customer 1" }
    phoneno { "9089098789" }
  end
end
