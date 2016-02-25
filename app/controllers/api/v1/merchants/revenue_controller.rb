class Api::V1::Merchants::RevenueController < Api::ApiController
  respond_to :json

  def show
    if params[:date]
      merchants = Merchant.select("sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:transactions, :invoice_items])
      .group('merchants.id')
      .where('transactions.result = ?', "success")
      .where('invoices.updated_at = ?', "#{params[:date]}")
      .where('merchants.id = ?', "#{params[:merchant_id]}")
      .order('revenue desc')
      .take(params[:quantity])
    else
      merchants = Merchant.select("sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:transactions, :invoice_items])
      .group('merchants.id')
      .where('transactions.result = ?', "success")
      .where('merchants.id = ?', "#{params[:merchant_id]}")
      .order('revenue desc')
      .take(params[:quantity])
    end
    revenue = {revenue: merchants.revenue}
    respond_with revenue
  end

  def index
    merchants = Merchant.select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .joins(invoices: [:transactions, :invoice_items])
    .group('merchants.id')
    .where('transactions.result = ?', "success")
    .order('total_revenue desc')
    .take(params[:quantity])
    respond_with merchants
  end

  # def show
  #   b = Invoice.all.select do |invoice|
  #     invoice.transactions.any?{|t| t.result == 'success'}
  #   end
  #
  #   c = b.first.invoice_items.reduce(0) do |result, ii|
  #
  #       result = result + ii.unit_price
  #   end
  #   # c = b.reduce do |result, invoice|
  #   #   invoice.invoice_items.reduce do |result, ii|
  #   #     binding.pry
  #   #     ii.unit_price
  #   #   end
  #   # end
  #   # binding.pry
  #   respond_with Invoice.joins(:invoice_items, :transactions).where('transactions.result = ?', "success").where(merchant_id: 1).sum(:unit_price)
  # end
end
