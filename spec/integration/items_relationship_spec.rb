require 'rails_helper'

RSpec.describe "Items Relationship API" do
  it "returns all invoice_items from an item" do
    item = create(:item)
    create_list(:invoice_item, 1)
    invoice_items = create_list(:invoice_item, 2, item: item)

    get "/api/v1/items/#{item.id}/invoice_items"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns item's merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(merchant.id)
  end
end
