require 'rails_helper'

RSpec.describe "Merchants API" do
  it "returns all merchants" do
    merchants = create_list(:merchant, 2)

    get '/api/v1/merchants'
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns a merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(merchant.name)
  end

  it "finds a merchant by id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(merchant.name)
  end

  it "finds a merchant by name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(merchant.name)
  end

  it "finds a merchant by name case insensitive" do
    merchant = create(:merchant, name: 'Peter Bob')

    get "/api/v1/merchants/find?name=pETeR bOB"

    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(merchant.name)
  end

  it "finds a merchant by created_at" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(merchant.name)
  end

  it "finds a merchant by created_at using date format from the csv" do
    merchant = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(merchant.name)
  end

  it "finds a merchant by updated_at" do
    merchant = create(:merchant)

    # get :show, created_at: "2012-03-27T14:54:05.000Z"
    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)
    # binding.pry
    json = JSON.parse(response.body)
    expect(json['name']).to eq(merchant.name)
  end

  it "returns a random merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/random"

    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq(merchant.name)
  end

  it "finds all merchants by id" do
    merchant_1, merchant_2 = create_list(:merchant, 2)

    get "/api/v1/merchants/find_all?id=#{merchant_1.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json.first['name']).to eq(merchant_1.name)
    expect(json.count).to eq(1)
  end

  it "finds all merchants by name" do
    merchant_1 = create(:merchant, name:'bob')
    merchant_2 = create(:merchant, name:'bob')

    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all merchants by name case insensitive" do
    merchant_1 = create(:merchant, name:'bob')
    merchant_2 = create(:merchant, name:'BoB')

    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

end
