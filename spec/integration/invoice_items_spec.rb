require 'rails_helper'

RSpec.describe "InvoiceItems API" do
  it "returns all invoice_items" do
    invoice_items = create_list(:invoice_item, 2)

    get '/api/v1/invoice_items'
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns an invoice_item" do
    _, invoice_item = create_list(:invoice_item, 2)

    get "/api/v1/invoice_items/#{invoice_item.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice_item.id)
  end

  it "finds an invoice_item by id" do
    _, invoice_item = create_list(:invoice_item, 2)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice_item.id)
  end

  it "finds an invoice_item by quantity" do
    _, invoice_item = create_list(:invoice_item, 2)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice_item.id)
  end

  it "finds an invoice_item by unit price" do
    _, invoice_item = create_list(:invoice_item, 2)

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item.unit_price}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice_item.id)
  end

  it "finds an invoice_item by item_id" do
    item = create(:item)
    create(:invoice_item)
    invoice_item = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice_item.id)
  end

  it "finds an invoice_item by invoice_id" do
    invoice = create(:invoice)
    create(:invoice_item)
    invoice_item = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice_item.id)
  end

  it "finds an invoice_item by created_at" do
    create(:invoice_item)
    invoice_item = create(:invoice_item, created_at: Date.today + 7)

    get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice_item.id)
  end

  it "finds an invoice_item by created_at using date format from the csv" do
    create(:invoice_item)
    invoice_item = create(:invoice_item, created_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice_item.id)
  end

  it "finds an invoice_item by updated_at" do
    create(:invoice_item)
    invoice_item = create(:invoice_item, updated_at: Date.today + 7)

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item.updated_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice_item.id)
  end

  it "finds all invoice_items by id" do
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2)

    get "/api/v1/invoice_items/find_all?id=#{invoice_item_1.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json.first['id']).to eq(invoice_item_1.id)
    expect(json.count).to eq(1)
  end

  it "finds all invoice_items by quantity" do
    create(:invoice_item)
    invoice_item_1 = create(:invoice_item, quantity: 999)
    invoice_item_2 = create(:invoice_item, quantity: 999)

    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item_1.quantity}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all invoice_items by unit_price" do
    create(:invoice_item)
    invoice_item_1 = create(:invoice_item, unit_price: 7)
    invoice_item_2 = create(:invoice_item, unit_price: 7)

    get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item_1.unit_price}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all invoice_items by invoice_id" do
    invoice = create(:invoice)
    create(:invoice_item)
    invoice_item_1, _ = create_list(:invoice_item, 2, invoice: invoice)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item_1.invoice_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all invoice_items by item_id" do
    item = create(:item)
    create(:invoice_item)
    invoice_item_1, _ = create_list(:invoice_item, 2, item: item)

    get "/api/v1/invoice_items/find_all?item_id=#{invoice_item_1.item_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "returns a random invoice_item" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/random"

    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice_item.id)
  end
end
