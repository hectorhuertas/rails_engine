require 'rails_helper'

RSpec.describe "Transaction Relationship API" do
  it "returns transaction's invoice" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/#{transaction.id}/invoice"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end
end
