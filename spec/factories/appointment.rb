FactoryBot.define do
  factory :appointment do
    tenant { FactoryBot.create(:tenant) }
    user { FactoryBot.create(:user, tenant: tenant) }
    customer { FactoryBot.create(:customer, tenant: tenant) }
    property { FactoryBot.create(:property, tenant: tenant) }
    date { Date.today }
    time { Time.now }
  end
end