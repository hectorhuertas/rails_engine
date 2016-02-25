require 'rails_helper'

RSpec.describe "Merchants Relationship API" do
  # it  "total revenue for a merchant across all transactions" do
  #   t_1 = create(:transaction, result: 'success')
  #   t_2 = create(:transaction, result: 'fail')
  #   t_3 = create(:transaction, result: 'fail')
  #   t_4 = create(:transaction, result: 'fail')
  #   ii_1 = create(:invoice_item, unit_price: 15)
  #   ii_2 = create(:invoice_item, unit_price: 20)
  #   ii_3 = create(:invoice_item, unit_price: 15)
  #   ii_4 = create(:invoice_item, unit_price: 20)
  #   inv_1 = create(:invoice, invoice_items: [ii_1, ii_2], transactions: [t_1, t_2])
  #   inv_2 = create(:invoice, invoice_items: [ii_3, ii_4], transactions: [t_3, t_4])
  #   merchant = create(:merchant, invoices: [inv_1,inv_2])
  #
  #   get "/api/v1/merchants/#{merchant.id}/revenue"
  #
  #   expect(response).to be_success
  #   expect(response).to have_http_status(200)
  #
  #   json = JSON.parse(response.body)
  #   expect(json).to eq("sdfsaf")
  # end
  # it "returns top merchant by total revenue" do
  #   create_list(:item, 1)
  #   items = create_list(:item, 2)
  #   invoice_items = create_list(:invoice_item, 2)
  #   merchant = create(:merchant, items: items)
  #   merchant = create(:merchant, items: items)
  #
  #   quantity = 1
  #
  #   get "/api/v1/merchants/:id/customers_with_pending_invoices"
  #   expect(response).to be_success
  #   expect(response).to have_http_status(200)
  #
  #   json = JSON.parse(response.body)
  #   expect(json.length).to eq(2)
  # end
  # it "returns top merchant by total revenue" do
  #   create_list(:item, 1)
  #   items = create_list(:item, 2)
  #   invoice_items = create_list(:invoice_item, 2)
  #   merchant = create(:merchant, items: items)
  #   merchant = create(:merchant, items: items)
  #
  #   quantity = 1
  #
  #   get "/api/v1/merchants/most_revenue?quantity=#{quantity}"
  #   expect(response).to be_success
  #   expect(response).to have_http_status(200)
  #
  #   json = JSON.parse(response.body)
  #   expect(json.length).to eq(2)
  # end

  # it "returns top 3 merchants by total revenue" do
  #   pending
  #   create_list(:item, 1)
  #   items = create_list(:item, 2)
  #   invoice_items = create_list(:invoice_item, 2)
  #   merchant = create(:merchant, items: items)
  #   merchant = create(:merchant, items: items)
  #
  #   quantity = 3
  #
  #   get "/api/v1/merchants/most_revenue?quantity=#{quantity}"
  #   expect(response).to be_success
  #   expect(response).to have_http_status(200)
  #
  #   json = JSON.parse(response.body)
  #   expect(json.length).to eq("sdf")
  # end
end
