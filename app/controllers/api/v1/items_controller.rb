class Api::V1::ItemsController < Api::ApiController
  respond_to :json

  def index
    if params[:merchant_id]
      respond_with Item.where(merchant_id: params[:merchant_id])
    else
      respond_with Item.all
    end
  end

  def show
    respond_with Item.find(params[:id])
  end
end
