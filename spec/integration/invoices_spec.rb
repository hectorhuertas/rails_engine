require 'rails_helper'

RSpec.describe "Invoices API" do
  it "returns all invoices" do
    invoices = create_list(:invoice, 2)

    get '/api/v1/invoices'
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns an invoice" do
    _, invoice = create_list(:invoice, 2)

    get "/api/v1/invoices/#{invoice.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end

  it "finds an invoice by id" do
    _, invoice = create_list(:invoice, 2)

    get "/api/v1/invoices/find?id=#{invoice.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end

  it "finds an invoice by status" do
    _, invoice = create_list(:invoice, 2)

    get "/api/v1/invoices/find?status=#{invoice.status}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end

  it "finds an invoice by status case insensitive" do
    create(:invoice)
    invoice = create(:invoice, status: 'Peter Bob')

    get "/api/v1/invoices/find?status=pETeR bOB"

    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end

  it "finds an invoice by merchant_id" do
    merchant = create(:merchant)
    create(:invoice)
    invoice = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end

  it "finds an invoice by customer_id" do
    merchant = create(:merchant)
    customer = create(:customer)
    create(:invoice)
    invoice = create(:invoice, merchant: merchant, customer: customer)

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end

  it "finds an invoice by created_at" do
    create(:invoice)
    invoice = create(:invoice, created_at: Date.today + 7)

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end

  it "finds an invoice by created_at using date format from the csv" do
    create(:invoice)
    invoice = create(:invoice, created_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end

  it "finds an invoice by updated_at" do
    create(:invoice)
    invoice = create(:invoice, updated_at: Date.today + 7)

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end

  it "finds all invoices by id" do
    invoice_1, invoice_2 = create_list(:invoice, 2)

    get "/api/v1/invoices/find_all?id=#{invoice_1.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json.first['id']).to eq(invoice_1.id)
    expect(json.count).to eq(1)
  end

  it "finds all invoices by status" do
    create(:invoice)
    invoice_1 = create(:invoice, status:'bob')
    invoice_2 = create(:invoice, status:'bob')

    get "/api/v1/invoices/find_all?status=#{invoice_1.status}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all invoices by status case insensitive" do
    create(:invoice)
    invoice_1 = create(:invoice, status:'bob')
    invoice_2 = create(:invoice, status:'BoB')

    get "/api/v1/invoices/find_all?status=#{invoice_1.status}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all invoices by merchant_id" do
    merchant = create(:merchant)
    create(:invoice)
    invoice_1, _ = create_list(:invoice, 2, merchant: merchant)

    get "/api/v1/invoices/find_all?merchant_id=#{invoice_1.merchant_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all invoices by customer_id" do
    merchant = create(:merchant)
    customer = create(:customer)
    create(:invoice)
    invoice_1, _ = create_list(:invoice, 2, merchant: merchant, customer: customer)

    get "/api/v1/invoices/find_all?customer_id=#{invoice_1.customer_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "returns a random invoice" do
    invoice = create(:invoice)

    get "/api/v1/invoices/random"

    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(invoice.id)
  end
end
