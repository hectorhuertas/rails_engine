require 'rails_helper'

RSpec.describe "invoice_item_items Relationship API" do
  it "returns invoice_item's invoice" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end

  it "returns invoice_item's item" do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(item.id)
  end

  # it "returns invoice_item's merchant" do
  #   merchant = create(:merchant)
  #   invoice_item = create(:invoice_item, merchant: merchant)
  #
  #   get "/api/v1/invoice_items/#{invoice_item.id}/merchant"
  #   expect(response).to be_success
  #   expect(response).to have_http_status(200)
  #
  #   json = JSON.parse(response.body)
  #   expect(json['id']).to eq(merchant.id)
  # end
end
