class Api::V1::Invoices::RandomController < Api::ApiController
  respond_to :json

  def show
    respond_with Invoice.offset(rand(Invoice.count)).first
  end
end
