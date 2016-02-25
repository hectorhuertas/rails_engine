require 'rails_helper'

RSpec.describe Item, :type => :model do
  it "saves the unit_price as dollars instead of cents" do
    item = Item.create(unit_price: 12345)
    expect(item.reload.unit_price.to_s).to eq('123.45')
  end

  it "has an invoice_item" do
    invoice_item = create(:invoice_item)
    item = create(:item, invoice_item: invoice_item)

    expect(item.invoice_item.id).to eq(invoice_item.id)
  end

  it  "has many invoices" do
    invoices = create_list(:invoice, 2)
    item = create(:item, invoices: invoices)

    expect(item.invoices.size).to eq(2)
  end
end
