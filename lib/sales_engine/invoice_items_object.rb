class InvoiceItemsObject

  attr_accessor :ii_invoice_items_id, :ii_item_id, :ii_invoice_id,
                :ii_quantity, :ii_unit_price, :ii_created_at, :ii_updated_at

  def initialize(attributes = {})
    self.ii_invoice_items_id    = attributes[:id]
    self.ii_item_id             = attributes[:item_id]
    self.ii_invoice_id          = attributes[:invoice_id]
    self.ii_quantity            = attributes[:quantity]
    self.ii_unit_price          = attributes[:unit_price]
    self.ii_created_at          = attributes[:created_at]
    self.ii_updated_at          = attributes[:updated_at]
  end
end
