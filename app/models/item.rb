class Item < ActiveRecord::Base
  belongs_to :merchant
  has_one :invoice_item
  has_many :invoices, through: :invoice_item

  before_save :dollarize

  def dollarize
    self.unit_price = unit_price.to_f / 100.0.to_f
  end
end
