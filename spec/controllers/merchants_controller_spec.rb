require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, :type => :controller do
  describe "GET #index" do
    it "returns all merchants" do
      merchants = create_list(:merchant, 2)

      get :index

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(json.length).to eq(2)
    end
  end

  describe "GET #show" do
    it "returns a merchant" do
      merchant = create(:merchant)

      # get "/api/v1/merchants/1"
      get :show, id: merchant.id

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(json['name']).to eq(merchant.name)
    end
  end
end
