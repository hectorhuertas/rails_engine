require 'rails_helper'

RSpec.describe "Merchants Relationship API" do
  it "returns all items from a merchant" do
    create_list(:item, 1)
    items = create_list(:item, 2)
    merchant = create(:merchant, items: items)

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns all invoices from a merchant" do
    create_list(:invoice, 1)
    invoices = create_list(:invoice, 2)
    merchant = create(:merchant, invoices: invoices)

    get "/api/v1/merchants/#{merchant.id}/invoices"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end
end
