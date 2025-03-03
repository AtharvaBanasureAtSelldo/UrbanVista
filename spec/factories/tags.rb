FactoryBot.define do
  factory :tag do
    tenant { FactoryBot.create(:tenant) }
    name { "Test Tag" }
  end
end
