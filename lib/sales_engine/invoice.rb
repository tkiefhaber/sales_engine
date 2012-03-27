module SalesEngine

  class Invoice

    attr_accessor :results, :input, :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

    def initialize(attributes = {})
      self.id               = attributes[:id]
      self.customer_id      = attributes[:customer_id]
      self.merchant_id      = attributes[:merchant_id]
      self.status           = attributes[:status]
      self.created_at       = attributes[:created_at]
      self.updated_at       = attributes[:updated_at]
    end

    def self.random
      return SalesEngine::Database.instance.invoices_data.sample
    end

    class << self
      [:id, :customer_id, :merchant_id, :status, :created_at, :updated_at].each do |attribute|
        define_method "find_by_#{attribute}" do |parameter|
          @input = parameter.downcase
          SalesEngine::Database.instance.invoices_data.find do |dataline|
            dataline.send(attribute.to_s).downcase == @input
          end
        end

        define_method "find_all_by_#{attribute}" do |parameter|
          @input = parameter.downcase
          SalesEngine::Database.instance.invoices_data.select do |dataline|
            dataline.send(attribute.to_s).downcase == @input
          end
        end 
      end
    end

    def transactions=(input)
      # self.merchant_id = input.id
      @transactions = input
    end

    def transactions
      puts self.id
      # returns the items for a given instance of merchant
      @transactions || SalesEngine::Database.instance.transactions_data.select do |transaction_object|
        self.id == transaction_object.send(:invoice_id)
      end
    end

    def invoice_items=(input)
      # self.merchant_id = input.id
      @invoice_items = input
    end

    def invoice_items
      # returns the items for a given instance of merchant
      @invoice_items || SalesEngine::Database.instance.invoice_items_data.select do |invoice_item_object|
        self.id == invoice_item_object.send(:invoice_id)
      end
    end

    def customers=(input)
      # self.merchant_id = input.id
      @customers = input
    end

    def customer
      puts "This is the invoice: #{self.id}"
      # returns the items for a given instance of merchant
      @customer ||= SalesEngine::Database.instance.customers_data.find do |customers_object|
        self.customer_id == customers_object.send(:id)
      end
    end

    def items=(input)
      # self.merchant_id = input.id
      @items = input
    end

    def items
      puts "This is the invoice id: #{self.id}"
      invoice_items.map do |invoice_item|
        invoice_item.item
      end
    end

    def successful?
      transactions.each do |t|
        if t.result == "success"
          true
        else
          false
        end
      end
    end

  end
end
