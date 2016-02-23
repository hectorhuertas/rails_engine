FactoryGirl.define do
  factory :merchant do
    sequence(:name) { |i| "Merchant no #{i}" }
    created_at Date.today
    updated_at Date.today
  end
end
