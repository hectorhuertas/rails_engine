class Api::V1::MerchantsController < Api::ApiController
  def index
    render json: Merchant.all
  end
end
