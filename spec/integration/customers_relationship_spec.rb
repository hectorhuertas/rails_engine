require 'rails_helper'

RSpec.describe "Customers Relationship API" do
  it "returns all invoices from a customer" do
    customer = create(:customer)
    create(:invoice)
    invoices = create_list(:invoice, 2, customer: customer)

    get "/api/v1/customers/#{customer.id}/invoices"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns all transactions from a customer" do
    create_list(:transaction, 1)
    transactions_1 = create_list(:transaction, 2)
    transactions_2 = create_list(:transaction, 2)
    invoice_1 = create(:invoice, transactions: transactions_1)
    invoice_2 = create(:invoice, transactions: transactions_2)
    customer = create(:customer, invoices: [invoice_1, invoice_2])

    get "/api/v1/customers/#{customer.id}/transactions"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(4)
  end
end
