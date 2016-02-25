class Api::V1::Merchants::CustomersWithPendingInvoicesController < Api::ApiController
  respond_to :json

  def index
    # binding.pry
    b = Customer.select("customers.*")
                .joins(invoices: :transactions)
                .group('customers.id')
                .where('transactions.result = ?', "failed")
                .where('invoices.merchant_id = ?', "#{params[:merchant_id]}")
    respond_with b
  end
end
