class Api::V1::Merchants::ItemsController < Api::ApiController
  respond_to :json

  def index
    respond_with Item.where(merchant_id: params[:merchant_id])
  end
end
