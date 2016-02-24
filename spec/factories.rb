FactoryGirl.define do
  factory :transaction do
    invoice nil
    sequence(:credit_card_number) { |i| "Card number no #{i}" }
    sequence(:result) { |i| "Result no #{i}" }
    created_at Date.today
    updated_at Date.today
  end

  factory :invoice_item do
    item nil
    invoice nil
    sequence(:quantity) { |i| i }
    sequence(:unit_price) { |i| 100 + i }
    created_at Date.today
    updated_at Date.today
  end

  factory :invoice do
    customer nil
    merchant nil
    sequence(:status) { |i| "Status no #{i}" }
    created_at Date.today
    updated_at Date.today
  end

  factory :item do
    sequence(:name) { |i| "Item no #{i}" }
    sequence(:description) { |i| "Item description no #{i}" }
    sequence(:unit_price) { |i| 100 + i }
    merchant nil
    created_at Date.today
    updated_at Date.today
  end

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
