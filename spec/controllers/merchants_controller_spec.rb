require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, :type => :controller do
  describe "GET #index" do
    it "returns all merchants" do
      merchants = create_list(:merchant, 2)

      get :index

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      # binding.pry
      expect(json.length).to eq(2)
      # expect(assigns(:merchants)).to match_array(merchants)
    end
  end
end
