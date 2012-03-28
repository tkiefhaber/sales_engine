
class InvoicesObjects

  attr_accessor :in_invoices_id, :in_customer_id, :in_merchant_id,
                :in_status, :in_created_at, :in_updated_at

  def initialize(attributes = {})
    self.in_invoices_id      = attributes[:id]
    self.in_customer_id      = attributes[:customer_id]
    self.in_merchant_id      = attributes[:merchant_id]
    self.in_status           = attributes[:status]
    self.in_created_at       = attributes[:created_at]
    self.in_updated_at       = attributes[:updated_at]
  end
end