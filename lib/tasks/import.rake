require 'csv'

desc "Import csv files"

task import: [:environment] do

  file = "vendor/assets/csv/merchants.csv"
  CSV.foreach(file, headers: true) do |row|
    Merchant.create row.to_h
  end

  file = "vendor/assets/csv/customers.csv"
  CSV.foreach(file, headers: true) do |row|
    Customer.create row.to_h
  end

  file = "vendor/assets/csv/items.csv"
  CSV.foreach(file, headers: true) do |row|
    Item.create row.to_h
  end

  file = "vendor/assets/csv/invoices.csv"
  CSV.foreach(file, headers: true) do |row|
    Invoice.create row.to_h
  end

  file = "vendor/assets/csv/invoice_items.csv"
  CSV.foreach(file, headers: true) do |row|
    InvoiceItem.create row.to_h
  end

  file = "vendor/assets/csv/transactions.csv"
  CSV.foreach(file, headers: true) do |row|
    row.delete("credit_card_expiration_date")
    Transaction.create row.to_h
  end
end
