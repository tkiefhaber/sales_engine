module SalesEngine

  class Customer

    attr_accessor :results, :input, :id, 
                  :first_name, :last_name, 
                  :created_at, :updated_at

    def initialize(attributes = {})
      self.id              = attributes[:id].to_i
      self.first_name      = attributes[:first_name]
      self.last_name       = attributes[:last_name]
      self.created_at      = Date.parse(attributes[:created_at].to_s)
      self.updated_at      = Date.parse(attributes[:updated_at].to_s)
    end

    def invoice=(input)
      @invoice = input
    end

    def invoices=(input)
      @invoices = input
    end

    def self.random
      SalesEngine::Database.instance.customers_data.sample
    end

    class << self
      [:id, :first_name, :last_name, 
       :created_at, :updated_at].each do |attribute|
        define_method "find_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.customers_data.find do |customer|
            customer.send(attribute) == parameter
          end
        end

        define_method "find_all_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.customers_data.select do |customer|
            customer.send(attribute) == parameter
          end
        end 
      end
    end

    def invoices
      i = SalesEngine::Database.instance.invoices_data
      @invoices ||= i.select do |invoice|
        invoice.customer_id == self.id
      end
    end

    def transactions
      invoices.collect do |invoice|
        invoice.transactions
      end
    end

    def merchants
      @merchants ||= self.invoices.collect do |invoice|
        invoice.merchant
      end
    end

    def favorite_merchant
      merchant_by_transaction.first
    end

    def merchant_by_transaction
      merchants.sort_by do |merchant|
        -merchant.successful_transactions.size
      end
    end

  end
end