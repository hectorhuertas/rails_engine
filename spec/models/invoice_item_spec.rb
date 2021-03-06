require 'rails_helper'

RSpec.describe InvoiceItem, :type => :model do
  it "saves the unit_price as dollars instead of cents" do
    invoice_item = InvoiceItem.create(unit_price: 12345)
    expect(invoice_item.unit_price.to_s).to eq('123.45')
  end
end
