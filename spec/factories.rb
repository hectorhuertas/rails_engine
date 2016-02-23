FactoryGirl.define do
  factory :merchant do
    sequence(:name) { |i| "Merchant no #{i}" }
  end
end
