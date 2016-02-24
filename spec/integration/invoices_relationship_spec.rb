require 'rails_helper'

RSpec.describe "Invoices Relationship API" do
  it "returns all transactions from an invoice" do
    create_list(:transaction, 1)
    transactions = create_list(:transaction, 2)
    invoice = create(:invoice, transactions: transactions)

    get "/api/v1/invoices/#{invoice.id}/transactions"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns all invoice_items from an invoice" do
    create_list(:invoice_item, 1)
    invoice_items = create_list(:invoice_item, 2)
    invoice = create(:invoice, invoice_items: invoice_items)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns all items from an invoice" do
    create_list(:item, 1)
    items = create_list(:item, 2)
    invoice = create(:invoice, items: items)

    get "/api/v1/invoices/#{invoice.id}/items"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns invoice's customer" do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)

    get "/api/v1/invoices/#{invoice.id}/customer"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(customer.id)
  end

  it "returns invoice's merchant" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/#{invoice.id}/merchant"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(merchant.id)
  end
end
