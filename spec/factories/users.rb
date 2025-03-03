FactoryBot.define do
  factory :user do
    tenant { FactoryBot.create(:tenant) }
    name { "Testing Atharva" }
    email { "atharva2@gmail.com" }
    role { "admin" }
    phone { "9009090909" }
    password { "123456" }
  end
end
