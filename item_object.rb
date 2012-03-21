class Item_Object

  attr_accessor :item_id, :item_name, :item_description, :item_unit_price, :merchant_id, :item_created, :item_updated

  def initialize(attributes = {})
    self.item_id             = attributes[:id]
    self.item_name           = attributes[:name]
    self.item_description    = attributes[:description]
    self.item_unit_price     = attributes[:unit_price]
    self.merchant_id         = attributes[:merchant_id]
    self.item_created        = attributes[:created_at]
    self.item_updated        = attributes[:updated_at]
  end
end