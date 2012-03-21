
class Transactions_objects

  attr_accessor :t_transactions_id, :t_invoice_id, :t_credit_card_number,
                :t_credit_card_expiration, :t_result, 
                :t_created_at, :t_updated_at

  def initialize(attributes = {})
    self.t_transactions_id        = attributes[:id]
    self.t_invoice_id             = attributes[:invoice_id]
    self.t_credit_card_number     = attributes[:credit_card_number]
    self.t_credit_card_expiration = attributes[:credit_card_expiration]
    self.t_result                 = attributes[:result]
    self.t_created_at             = attributes[:created_at]
    self.t_updated_at             = attributes[:updated_at]
  end
end