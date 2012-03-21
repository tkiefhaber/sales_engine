
class Invoices_objects

  attr_accessor :i_invoices_id, :i_customer_id, :i_merchant_id,
                :i_status, :i_created_at, :i_updated_at

  def initialize(attributes = {})
    self.i_invoices_id      = attributes[:id]
    self.i_customer_id      = attributes[:customer_id]
    self.i_merchant_id      = attributes[:merchant_id]
    self.i_status           = attributes[:status]
    self.i_created_at       = attributes[:created_at]
    self.i_updated_at       = attributes[:updated_at]
  end
end