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
      # returns the items for a given instance of merchant
      @invoices || SalesEngine::Database.instance.invoices_data.select do |item_object|
        self.id == item_object.send(:customer_id) 
      end
    end

    def successful_transactions
      self.invoices.select do |transaction|
        transaction.successful?
      end

    end

  end
end