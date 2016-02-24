require 'rails_helper'

RSpec.describe "Transactions API" do
  it "returns all transactions" do
    transactions = create_list(:transaction, 2)

    get '/api/v1/transactions'
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns a transaction" do
    _, transaction = create_list(:transaction, 2)

    get "/api/v1/transactions/#{transaction.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(transaction.id)
  end

  it "finds a transaction by id" do
    _, transaction = create_list(:transaction, 2)

    get "/api/v1/transactions/find?id=#{transaction.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(transaction.id)
  end

  it "finds a transaction by result" do
    _, transaction = create_list(:transaction, 2)

    get "/api/v1/transactions/find?result=#{transaction.result}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(transaction.id)
  end

  it "finds a transaction by credit_card_number" do
    _, transaction = create_list(:transaction, 2)

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(transaction.id)
  end

  it "finds a transaction by invoice_id" do
    invoice = create(:invoice)
    create(:transaction)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(transaction.id)
  end

  it "finds a transaction by created_at" do
    create(:transaction)
    transaction = create(:transaction, created_at: Date.today + 7)

    get "/api/v1/transactions/find?created_at=#{transaction.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(transaction.id)
  end

  it "finds a transaction by created_at using date format from the csv" do
    create(:transaction)
    transaction = create(:transaction, created_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/transactions/find?created_at=#{transaction.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(transaction.id)
  end

  it "finds a transaction by updated_at" do
    create(:transaction)
    transaction = create(:transaction, updated_at: Date.today + 7)

    get "/api/v1/transactions/find?updated_at=#{transaction.updated_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(transaction.id)
  end

  it "finds all transactions by id" do
    transaction_1, transaction_2 = create_list(:transaction, 2)

    get "/api/v1/transactions/find_all?id=#{transaction_1.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json.first['id']).to eq(transaction_1.id)
    expect(json.count).to eq(1)
  end

  it "finds all transactions by result" do
    create(:transaction)
    transaction_1 = create(:transaction, result: 'success')
    transaction_2 = create(:transaction, result: 'success')

    get "/api/v1/transactions/find_all?result=#{transaction_1.result}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all transactions by credit_card_number" do
    create(:transaction)
    transaction_1 = create(:transaction, credit_card_number: 'success')
    transaction_2 = create(:transaction, credit_card_number: 'success')

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction_1.credit_card_number}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all transactions by invoice_id" do
    invoice = create(:invoice)
    create(:transaction)
    transaction_1, _ = create_list(:transaction, 2, invoice: invoice)

    get "/api/v1/transactions/find_all?invoice_id=#{transaction_1.invoice_id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "returns a random transaction" do
    transaction = create(:transaction)

    get "/api/v1/transactions/random"

    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['id']).to eq(transaction.id)
  end
end
