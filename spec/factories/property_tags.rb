FactoryBot.define do
  factory :property_tag do
    property { FactoryBot.create(:property) }
    tag { FactoryBot.create(:tag) }
  end
end
