class Item < ActiveRecord::Base
  belongs_to :merchant

  before_save :dollarize

  def dollarize
    self.unit_price = unit_price.to_f / 100.0.to_f
  end
end
