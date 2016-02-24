class Api::V1::Items::SearchController < Api::ApiController
  respond_to :json

  def show
    respond_with Item.where(search_params).first
  end

  def index
    respond_with Item.where(search_params)
  end

  private

  def search_params
    DateSearch.at(params) || params.permit(:id,
                                           :name,
                                           :description,
                                           :unit_price,
                                           :merchant_id)
  end
end
