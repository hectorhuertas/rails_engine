class Api::V1::Merchants::MostRevenueController < Api::ApiController
  respond_to :json

  def index
    # binding.pry
    x = Merchant.all.sort_by do |i|
      # i.invoice_items.sum(:unit_price)
      # Invoice.where(merchant_id: i.id).joins(:invoice_items).sum(:unit_price)
      Invoice.where(merchant_id: i.id).joins(:invoice_items).joins(:transactions).where("transactions.result = 'success'").sum(:unit_price)
    end.reverse.take(params[:quantity].to_i)
    # binding.pry
    # InvoiceItem.sum(:price)
    respond_with x
  end
end
# "users.active_list_id  = lists.id"
