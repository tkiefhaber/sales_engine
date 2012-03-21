
class Invoice_items_objects

  attr_accessor :it_invoice_items_id, :it_item_id, :it_invoice_id,
                :it_quantity, :it_unit_price, :it_created_at, :it_updated_at

  def initialize(attributes = {})
    self.it_invoice_items_id    = attributes[:id]
    self.it_item_id             = attributes[:item_id]
    self.it_invoice_id          = attributes[:invoice_id]
    self.it_quantity            = attributes[:quantity]
    self.it_unit_price          = attributes[:unit_price]
    self.it_created_at          = attributes[:created_at]
    self.it_updated_at          = attributes[:updated_at]
  end
end