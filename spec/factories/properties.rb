FactoryBot.define do
  factory :property do
    tenant { FactoryBot.create(:tenant) }
    user { FactoryBot.create(:user1, tenant: tenant) }
    title { "Test Property 1" }
    address { "Test Pune" }
    price { 10000000 }
  end
end
