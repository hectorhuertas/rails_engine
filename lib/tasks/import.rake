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
end
