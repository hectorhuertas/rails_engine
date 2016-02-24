class Api::V1::Invoices::CustomersController < Api::ApiController
  respond_to :json

  def show
    respond_with Invoice.find(params[:invoice_id]).customer
  end
end
