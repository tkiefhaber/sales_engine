class Merchant_Object

  attr_accessor :merchant_id, :merchant_name, :merchant_created, :merchant_updated

  def initialize(attributes = {})
    self.merchant_id        = attributes[:id]
    self.merchant_name      = attributes[:name]
    self.merchant_created   = attributes[:created_at]
    self.merchant_updated   = attributes[:updated_at]
  end
end