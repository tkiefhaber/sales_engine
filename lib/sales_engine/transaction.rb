module SalesEngine

  class Transaction

    attr_accessor :id, :invoice_id, :creditcard_number, :creditcard_expiration, :result, :created_at, :updated_at

    def initialize(attributes = {})
      self.id                      = attributes[:id]
      self.invoice_id              = attributes[:invoice_id]
      self.creditcard_number       = attributes[:creditcard_number]
      self.creditcard_expiration   = attributes[:creditcard_expiration]
      self.result                  = attributes[:result]
      self.created_at              = Date.parse(attributes[:created_at])
      self.updated_at              = Date.parse(attributes[:updated_at])
    end

    def invoice=(input)
      @invoice = input
    end

    def invoice
      @invoice ||= SalesEngine::Database.instance.invoices_data.detect do |invoice|
        self.invoice_id == invoice.id
      end
    end

    def successful?
      result == "success"
    end

    def self.create(attributes={})
      t= Transaction.new(:id                  => attributes[:id],
                      :invoice_id             => attributes[:invoice_id],
                      :credit_card_number     => attributes[:credit_card_number],
                      :credit_card_expiration => attributes[:credit_card_expiration],
                      :result                 => attributes[:result],
                      :created_at          => Time.now.to_s,
                      :updated_at          => Time.now.to_s)
      SalesEngine::Database.add_transaction(t)
    end
  end
end
