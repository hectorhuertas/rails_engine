class Api::V1::Customers::FavoriteMerchantController < Api::ApiController
  respond_to :json

  def show
    # merchant = Merchant.select("merchants.*, count()")
    #                    .joins(:invoice)
    #                    .where(customer_id: params[:customer_id])
    #                    .group(:merchant_id)

    merchant = Invoice.where(customer_id: params[:customer_id])
                      .group(:merchant_id).count.sort_by{|k,v| v}
                      .reverse.first.first
    respond_with Merchant.find(merchant)
  end
end
