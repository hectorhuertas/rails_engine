class Api::V1::Merchants::MostRevenueController < Api::ApiController
  respond_to :json

  def index
    merchant = Merchant.all.sort_by do |i|
      Invoice.where(merchant_id: i.id)
             .joins(:invoice_items, :transactions)
             .where("transactions.result = 'success'")
             .sum(:unit_price)
    end.reverse.take(params[:quantity].to_i)
    respond_with merchant
  end
end
