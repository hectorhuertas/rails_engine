class Api::V1::MerchantsController < Api::ApiController
  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find(params[:id])
  end
end
