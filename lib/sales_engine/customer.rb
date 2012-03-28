module SalesEngine

  class Customer

    attr_accessor :results, :input, :id, :first_name, :last_name, :created_at, :updated_at

    def initialize(attributes = {})
      self.id              = attributes[:id]
      self.first_name      = attributes[:first_name]
      self.last_name       = attributes[:last_name]
      self.created_at      = Date.parse(attributes[:created_at])
      self.updated_at      = Date.parse(attributes[:updated_at])
    end

    def self.random
      SalesEngine::Database.instance.customers_data.sample
    end

    def self.create(*args)
      raise "Create: " + args.join(", ")
    end


    class << self
      [:id, :first_name, :last_name, :created_at, :updated_at].each do |attribute|
        define_method "find_by_#{attribute}" do |parameter|
          @input = parameter.downcase
          SalesEngine::Database.instance.customers_data.find do |dataline|
            dataline.send(attribute.to_s).downcase == @input
          end
        end

        define_method "find_all_by_#{attribute}" do |parameter|
          @input = parameter.downcase
          SalesEngine::Database.instance.customers_data.select do |dataline|
            dataline.send(attribute.to_s).downcase == @input
          end
        end 
      end
    end

    def invoice=(input)
      @invoice = input
    end

    def invoices=(input)
      @invoices = input
    end

    def invoices
      @invoices ||= SalesEngine::Database.instance.invoices_data.select do |invoice|
        self.id == invoice.customer_id
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
        -merchant.invoices_with_successful_transactions.size
      end
    end

    def invoices_with_successful_transactions
      self.invoices.collect do |invoice|
        invoice.successful?
      end
    end

  end
end