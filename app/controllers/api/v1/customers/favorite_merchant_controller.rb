class Api::V1::Customers::FavoriteMerchantController < Api::ApiController
  respond_to :json

  def show
    favorite_merchant = Invoice.where(customer_id: params[:customer_id]).group(:merchant_id).count.sort_by{|k,v| v}.reverse.first.first
    respond_with Merchant.find(favorite_merchant)
  end
end
