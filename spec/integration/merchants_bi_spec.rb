require 'rails_helper'

RSpec.describe "Merchants Relationship API" do
  it "returns top merchant by total revenue" do
    create_list(:item, 1)
    items = create_list(:item, 2)
    invoice_items = create_list(:invoice_item, 2)
    merchant = create(:merchant, items: items)
    merchant = create(:merchant, items: items)

    quantity = 1

    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns top 3 merchants by total revenue" do
    create_list(:item, 1)
    items = create_list(:item, 2)
    invoice_items = create_list(:invoice_item, 2)
    merchant = create(:merchant, items: items)
    merchant = create(:merchant, items: items)

    quantity = 3

    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

# GET /api/v1/merchants/most_revenue?quantity=x
# returns the top x merchants ranked by total revenue

  # it "returns all invoices from a merchant" do
  #   create_list(:invoice, 1)
  #   invoices = create_list(:invoice, 2)
  #   merchant = create(:merchant, invoices: invoices)
  #
  #   get "/api/v1/merchants/#{merchant.id}/invoices"
  #   expect(response).to be_success
  #   expect(response).to have_http_status(200)
  #
  #   json = JSON.parse(response.body)
  #   expect(json.length).to eq(2)
  # end
end
