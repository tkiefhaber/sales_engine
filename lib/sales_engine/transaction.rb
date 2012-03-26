module SalesEngine

  class Transaction

    attr_accessor :id, :invoice_id, :credicard_number, :credicard_expiration, :result, :created_at, :updated_at

    def initialize(attributes = {})
      self.id                     = attributes[:id]
      self.invoice_id             = attributes[:invoice_id]
      self.credicard_number       = attributes[:credicard_number]
      self.credicard_expiration   = attributes[:credicard_expiration]
      self.result                 = attributes[:result]
      self.created_at             = attributes[:created_at]
      self.updated_at             = attributes[:updated_at]
    end

  end
end