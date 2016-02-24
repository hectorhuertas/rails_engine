require 'rails_helper'

RSpec.describe Item, :type => :model do
  it "saves the unit_price as dollars instead of cents" do
    pending
    item = Item.create(unit_price: 12345)
    expect(item.reload.unit_price).to eq('123,45')
  end
end
