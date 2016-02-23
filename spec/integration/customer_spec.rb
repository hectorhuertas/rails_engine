require 'rails_helper'

RSpec.describe "Customers API" do
  it "returns all customers" do
    customers = create_list(:customer, 2)

    get '/api/v1/customers'
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
  end

  it "returns a customer" do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['first_name']).to eq(customer.first_name)
  end

  it "finds a customer by id" do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['first_name']).to eq(customer.first_name)
  end

  it "finds a customer by first_name" do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['first_name']).to eq(customer.first_name)
  end

  it "finds a customer by last_name" do
    customer = create(:customer)

    get "/api/v1/customers/find?last_name=#{customer.last_name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['first_name']).to eq(customer.first_name)
  end

  it "finds a customer by first_name case insensitive" do
    customer = create(:customer, first_name: 'Peter Bob')

    get "/api/v1/customers/find?first_name=pETeR bOB"

    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['first_name']).to eq(customer.first_name)
  end

  it "finds a customer by last_name case insensitive" do
    customer = create(:customer, last_name: 'Peter Bob')

    get "/api/v1/customers/find?last_name=pETeR bOB"

    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['last_name']).to eq(customer.last_name)
  end

  it "finds a customer by created_at" do
    customer = create(:customer)

    get "/api/v1/customers/find?created_at=#{customer.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['first_name']).to eq(customer.first_name)
  end

  it "finds a customer by created_at using date format from the csv" do
    customer = create(:customer, created_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/customers/find?created_at=#{customer.created_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['first_name']).to eq(customer.first_name)
  end

  it "finds a customer by updated_at" do
    customer = create(:customer)

    # get :show, created_at: "2012-03-27T14:54:05.000Z"
    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"
    expect(response).to be_success
    expect(response).to have_http_status(200)
    # binding.pry
    json = JSON.parse(response.body)
    expect(json['first_name']).to eq(customer.first_name)
  end

  it "returns a random customer" do
    customer = create(:customer)

    get "/api/v1/customers/random"

    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['first_name']).to eq(customer.first_name)
  end

  it "finds all customers by id" do
    customer_1, customer_2 = create_list(:customer, 2)

    get "/api/v1/customers/find_all?id=#{customer_1.id}"
    expect(response).to be_success
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json.first['first_name']).to eq(customer_1.first_name)
    expect(json.count).to eq(1)
  end

  it "finds all customers by first_name" do
    customer_1 = create(:customer, first_name:'bob')
    customer_2 = create(:customer, first_name:'bob')

    get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all customers by first_name case insensitive" do
    customer_1 = create(:customer, first_name:'bob')
    customer_2 = create(:customer, first_name:'BoB')

    get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all customers by last_name" do
    customer_1 = create(:customer, last_name:'bob')
    customer_2 = create(:customer, last_name:'bob')

    get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

  it "finds all customers by last_name case insensitive" do
    customer_1 = create(:customer, last_name:'bob')
    customer_2 = create(:customer, last_name:'BoB')

    get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"
    expect(response).to be_success
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.count).to eq(2)
  end

end
