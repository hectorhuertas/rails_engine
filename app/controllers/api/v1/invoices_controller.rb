class Api::V1::InvoicesController < Api::ApiController
  respond_to :json

  def index
    if params[:merchant_id]
      respond_with Invoice.where(merchant_id: params[:merchant_id])
    else
      respond_with Invoice.all
    end
  end

  def show
    respond_with Invoice.find(params[:id])
  end
end
