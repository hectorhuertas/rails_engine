require 'csv'

desc "Import csv files"

task import: [:environment] do

  file = "vendor/assets/csv/merchants.csv"

  CSV.foreach(file, headers: true) do |row|
    # Merchant.create(name: row[:name])
    Merchant.create row.to_h
  end
end
