require 'rails_helper'

RSpec.describe Invoice, :type => :model do
  it  "has many transactions" do
    transactions = create_list(:transaction, 2)
    invoice = create(:invoice, transactions: transactions)

    expect(invoice.transactions.size).to eq(2)
  end

  it  "has many invoice_items" do
    invoice_items = create_list(:invoice_item, 2)
    invoice = create(:invoice, invoice_items: invoice_items)

    expect(invoice.invoice_items.size).to eq(2)
  end

  it  "has many items" do
    items = create_list(:item, 2)
    invoice = create(:invoice, items: items)

    expect(invoice.items.size).to eq(2)
  end
end
