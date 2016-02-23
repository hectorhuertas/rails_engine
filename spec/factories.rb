FactoryGirl.define do

  factory :customer do
    sequence(:first_name) { |i| "First name no #{i}" }
    sequence(:last_name) { |i| "Last name no #{i}" }
    created_at Date.today
    updated_at Date.today
  end

  factory :merchant do
    sequence(:name) { |i| "Merchant no #{i}" }
    created_at Date.today
    updated_at Date.today
  end
end
