require 'rails_helper'

RSpec.describe Merchant, :type => :model do
  context "when this" do
    it "does that thing" do
      expect(1+1).to eq(2)
    end
  end

  it  "has many items" do
    items = create_list(:item, 2)
    merchant = create(:merchant, items: items)

    expect(merchant.items.size).to eq(2)
  end

  it  "has many invoices" do
    invoices = create_list(:invoice, 2)
    merchant = create(:merchant, invoices: invoices)

    expect(merchant.invoices.size).to eq(2)
  end
end
