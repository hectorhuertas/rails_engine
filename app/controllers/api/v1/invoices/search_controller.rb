class Api::V1::Invoices::SearchController < Api::ApiController
  respond_to :json

  def index
    respond_with Invoice.where(search_params)
  end

  def show
    respond_with Invoice.where(search_params).first
  end

  private
    def search_params
      DateSearch.at(params) || params.permit(:id,
                                             :status,
                                             :merchant_id,
                                             :customer_id)
    end
end
