class ItemObject

  attr_accessor :it_item_id, :it_item_name, :it_item_description, :it_item_unit_price, :it_merchant_id, :it_item_created, :it_item_updated

  def initialize(attributes = {})
    self.it_item_id             = attributes[:id]
    self.it_item_name           = attributes[:name]
    self.it_item_description    = attributes[:description]
    self.it_item_unit_price     = attributes[:unit_price]
    self.it_merchant_id         = attributes[:merchant_id]
    self.it_item_created        = attributes[:created_at]
    self.it_item_updated        = attributes[:updated_at]
  end
end