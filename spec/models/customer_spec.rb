require 'rails_helper'

RSpec.describe Customer, :type => :model do
  it  "has many invoices" do
    invoices = create_list(:invoice, 2)
    customer = create(:customer, invoices: invoices)

    expect(customer.invoices.size).to eq(2)
  end
end
