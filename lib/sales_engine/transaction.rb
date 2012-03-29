module SalesEngine

  class Transaction

    attr_accessor :id, :invoice_id, :credit_card_number, 
                  :credit_card_expiration, :result, :created_at, :updated_at

    def initialize(attributes = {})
      self.id                       = attributes[:id].to_i
      self.invoice_id               = attributes[:invoice_id].to_i
      self.credit_card_number       = attributes[:credit_card_number]
      self.credit_card_expiration   = attributes[:credit_card_expiration]
      self.result                   = attributes[:result]
      self.created_at               = Date.parse(attributes[:created_at].to_s)
      self.updated_at               = Date.parse(attributes[:updated_at].to_s)
    end

    def self.random
      return SalesEngine::Database.instance.transactions_data.sample
    end

    class << self
      [:id, :invoice_id, :credit_card_number, :credit_card_expiration, 
        :result, :created_at, :updated_at].each do |attribute|
        define_method "find_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.transactions_data.find do |trans|
            trans.send(attribute) == parameter
          end
        end

        define_method "find_all_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.transactions_data.select do |trans|
            trans.send(attribute) == parameter
          end
        end 
      end
    end

    def invoice=(input)
      @invoice = input
    end

    def invoice
      inv = SalesEngine::Database.instance.invoices_data
      @invoice ||= inv.detect do |invoice|
        self.invoice_id == invoice.id
      end
    end

    def successful?
      result == "success"
    end

    def self.create(invoice_id, attributes={})
      t = Transaction.new(:id            => find_new_transaction_id,
                :invoice_id              => invoice_id,
                :credit_card_number      => attributes[:credit_card_number],
                :credit_card_expiration  => attributes[:credit_card_expiration],
                :result                  => attributes[:result],
                :created_at              => Time.now.to_s,
                :updated_at              => Time.now.to_s)
      SalesEngine::Database.instance.add_transaction(t)
      t
    end

    def self.find_new_transaction_id
      SalesEngine::Database.instance.transactions_data.size.to_i + 1
    end
  end
end
