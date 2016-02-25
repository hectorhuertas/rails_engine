class Api::V1::Merchants::FavoriteCustomerController < Api::ApiController
  respond_to :json

  def show
    favorite_customer = Invoice.where(merchant_id: params[:merchant_id]).group(:customer_id).count.sort_by{|k,v| v}.reverse.first.first
    respond_with Customer.find(favorite_customer)
  end
end
