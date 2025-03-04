FactoryBot.define do
  factory :user1, class: 'User' do
    tenant { FactoryBot.create(:tenant) }
    name { "Testing Atharva" }
    email { "atharva2@gmail.com" }
    role { "admin" }
    phone { "9009090909" }
    password { "123456" }
  end
  factory :user2, class: 'User' do
    tenant { FactoryBot.create(:tenant) }
    name { "Testing Snehal" }
    email { "snehal@gmail.com" }
    role { "admin" }
    phone { "9008978765" }
    password { "123456" }
  end
end
