class Api::V1::Items::InvoiceItemsController < Api::ApiController
  respond_to :json

  def index
    respond_with InvoiceItem.where(item_id: params[:item_id])
  end
end
