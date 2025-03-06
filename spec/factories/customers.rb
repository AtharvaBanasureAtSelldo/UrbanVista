FactoryBot.define do
  factory :customer do
    name { "Test Customer 1" }
    phoneno { "9089098789" }
    association :tenant
  end
end
