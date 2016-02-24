class Api::V1::Customers::InvoicesController < Api::ApiController
  respond_to :json

  def index
    respond_with Customer.find(params[:customer_id]).invoices
  end
end
