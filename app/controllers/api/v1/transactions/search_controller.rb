class Api::V1::Transactions::SearchController < Api::ApiController
  respond_to :json

  def show
    respond_with Transaction.where(search_params).first
  end

  def index
    respond_with Transaction.where(search_params)
  end

  private

    def search_params
      DateSearch.at(params) || params.permit(:id,
                                             :result,
                                             :credit_card_number,
                                             :invoice_id)
    end
end
