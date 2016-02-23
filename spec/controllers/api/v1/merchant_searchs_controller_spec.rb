require 'rails_helper'

RSpec.describe Api::V1::MerchantSearchsController, :type => :controller do
  describe "GET #show" do
    it "returns merchant by id" do
      merchant = create(:merchant)

      get :show, id: merchant.id
      expect(response).to be_success
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json['name']).to eq(merchant.name)
    end

    it "returns merchant by name" do
      merchant = create(:merchant)

      get :show, name: merchant.name
      expect(response).to be_success
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json['name']).to eq(merchant.name)
    end

    it "returns merchant by name case insensitive" do
      merchant = create(:merchant)

      get :show, name: merchant.name.upcase

      expect(response).to be_success
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json['name']).to eq(merchant.name)
    end

    it "returns merchant by created_at" do
      merchant = create(:merchant)

      # get :show, created_at: "2012-03-27T14:54:05.000Z"
      get :show, created_at: merchant.created_at
      expect(response).to be_success
      expect(response).to have_http_status(200)
      # binding.pry
      json = JSON.parse(response.body)
      expect(json['name']).to eq(merchant.name)
    end

    it "returns merchant by updated_at" do
      merchant = create(:merchant)

      # get :show, created_at: "2012-03-27T14:54:05.000Z"
      get :show, updated_at: merchant.updated_at
      expect(response).to be_success
      expect(response).to have_http_status(200)
      # binding.pry
      json = JSON.parse(response.body)
      expect(json['name']).to eq(merchant.name)
    end

    it "returns a random merchant" do
      merchant = create(:merchant)

      get :show

      expect(response).to be_success
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json['name']).to eq(merchant.name)
    end
    #
    # it "returns a random merchant from all of them" do
    #   merchant = create(:merchant)
    #   merchants = create_list(:merchant, 20)
    #
    #   get :show
    #
    #   expect(response).to be_success
    #   expect(response).to have_http_status(200)
    #
    #   json = JSON.parse(response.body)
    #   expect(json['name']).to_not eq(merchant.name)
    # end
  end

  describe "GET #index" do
    it "returns merchants by id" do
      merchant_1, merchant_2 = create_list(:merchant, 2)

      get :index, id: merchant_1.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.first['name']).to eq(merchant_1.name)
    end

    it "returns merchants by name" do
      merchant_1 = create(:merchant, name:'bob')
      merchant_2 = create(:merchant, name:'bob')

      get :index, name: merchant_1.name
      expect(response).to be_success
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json.count).to eq(2)
    end

    it "returns merchants by name case insensitive" do
      merchant_1 = create(:merchant, name:'bob')
      merchant_2 = create(:merchant, name:'BoB')

      get :index, name: merchant_1.name
      expect(response).to be_success
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json.count).to eq(2)
    end
  end
end
