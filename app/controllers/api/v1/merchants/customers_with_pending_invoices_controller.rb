class Api::V1::Merchants::CustomersWithPendingInvoicesController < Api::ApiController
  respond_to :json

  def index
    customer = Customer.select("customers.*")
                .joins(invoices: :transactions)
                .group('customers.id')
                .where('transactions.result = ?', "failed")
                .where('invoices.merchant_id = ?', "#{params[:merchant_id]}")
    respond_with customer
  end
end
