class Api::V1::Invoices::InvoiceItemsController < Api::ApiController
  respond_to :json

  def index
    # binding.pry
    respond_with InvoiceItem.where(invoice_id: params[:invoice_id])
  end
end
