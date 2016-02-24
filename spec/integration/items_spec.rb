require 'rails_helper'

RSpec.describe "Items API" do
  it "returns all items" do
    items = create_list(:item, 2)

    get '/api/v1/items'
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns an item" do
    _, item = create_list(:item, 2)

    get "/api/v1/items/#{item.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(item.name)
  end

  it "finds an item by id" do
    _, item = create_list(:item, 2)

    get "/api/v1/items/find?id=#{item.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(item.name)
  end

  it "finds an item by name" do
    _, item = create_list(:item, 2)

    get "/api/v1/items/find?name=#{item.name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(item.name)
  end

  it "finds an item by name case insensitive" do
    create(:item)
    item = create(:item, name: 'Peter Bob')

    get "/api/v1/items/find?name=pETeR bOB"

    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(item.name)
  end

  it "finds an item by description" do
    _, item = create_list(:item, 2)

    get "/api/v1/items/find?description=#{item.description}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(item.name)
  end

  it "finds an item by unit price" do
    _, item = create_list(:item, 2)

    get "/api/v1/items/find?unit_price=#{item.unit_price}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(item.name)
  end

  it "finds an item by merchant_id" do
    merchant = create(:merchant)
    create(:item)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/find?merchant_id=#{item.merchant_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(item.name)
  end

  it "finds an item by created_at" do
    create(:item)
    item = create(:item, created_at: Date.today + 7)

    get "/api/v1/items/find?created_at=#{item.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(item.name)
  end

  it "finds an item by created_at using date format from the csv" do
    create(:item)
    item = create(:item, created_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/items/find?created_at=#{item.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(item.name)
  end

  it "finds an item by updated_at" do
    create(:item)
    item = create(:item, updated_at: Date.today + 7)

    get "/api/v1/items/find?updated_at=#{item.updated_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(item.name)
  end

  it "finds all items by id" do
    item_1, item_2 = create_list(:item, 2)

    get "/api/v1/items/find_all?id=#{item_1.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json.first['name']).to eq(item_1.name)
    expect(json.count).to eq(1)
  end

  it "finds all items by name" do
    create(:item)
    item_1 = create(:item, name:'bob')
    item_2 = create(:item, name:'bob')

    get "/api/v1/items/find_all?name=#{item_1.name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all items by name case insensitive" do
    create(:item)
    item_1 = create(:item, name:'bob')
    item_2 = create(:item, name:'BoB')

    get "/api/v1/items/find_all?name=#{item_1.name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all items by description" do
    create(:item)
    item_1 = create(:item, description:'bob')
    item_2 = create(:item, description:'bob')

    get "/api/v1/items/find_all?description=#{item_1.description}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all items by unit_price" do
    create(:item)
    item_1 = create(:item, unit_price: 7)
    item_2 = create(:item, unit_price: 7)

    get "/api/v1/items/find_all?unit_price=#{item_1.unit_price}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all items by merchant_id" do
    merchant = create(:merchant)
    create(:item)
    item_1, _ = create_list(:item, 2, merchant: merchant)

    get "/api/v1/items/find_all?merchant_id=#{item_1.merchant_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "returns a random item" do
    item = create(:item)

    get "/api/v1/items/random"

    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(item.name)
  end
end
