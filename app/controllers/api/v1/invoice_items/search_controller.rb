class Api::V1::InvoiceItems::SearchController < Api::ApiController
  respond_to :json

  def index
    respond_with InvoiceItem.where(search_params)
  end

  def show
    respond_with InvoiceItem.where(search_params).first
  end

  private
    def search_params
      DateSearch.at(params) || params.permit(:id,
                                             :quantity,
                                             :unit_price,
                                             :item_id,
                                             :invoice_id)
    end
end
