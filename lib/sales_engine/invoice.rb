module SalesEngine

  class Invoice

    attr_accessor :results, :input, :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :merchant

    def initialize(attributes = {})
      self.id               = attributes[:id].to_i
      self.customer_id      = attributes[:customer_id].to_i
      self.merchant_id      = attributes[:merchant_id].to_i
      self.status           = attributes[:status]
      self.created_at       = Date.parse(attributes[:created_at].to_s)
      self.updated_at       = Date.parse(attributes[:updated_at].to_s)
    end

    def self.random
      return SalesEngine::Database.instance.invoices_data.sample
    end

    def paid?
      self.transactions.any? do |transaction|
        transaction.successful?
      end
    end

    class << self

      [:id, :customer_id, :merchant_id, :status, :created_at, :updated_at].each do |attribute|
        define_method "find_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.invoices_data.find do |invoice|
            invoice.send(attribute) == parameter
          end
        end

        define_method "find_all_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.invoices_data.select do |invoice|
            invoice.send(attribute) == parameter
          end
        end 
      end
    end

    def merchant=(input)
      self.merchant_id = input.id
      @merchant = input
    end

    def transaction=(input)
      @transaction = input
    end

    def transactions=(input)
      @transactions = input
    end

    def transactions
      @transactions || SalesEngine::Database.instance.transactions_data.select do |transaction|
        transaction.invoice_id == self.id
      end
    end

    def invoice_items=(input)
      @invoice_items = input
    end

    def invoice_items
      @invoice_items || SalesEngine::Database.instance.invoice_items_data.select do |invoice|
        self.id == invoice.invoice_id
      end
    end

    def customer=(input)
      @customer = input
    end

    def customer
      @customer ||= SalesEngine::Database.instance.customers_data.each do |customer|
        if customer.id == self.customer_id
          return customer
        end
      end
    end

    def merchant
      @merchant ||= SalesEngine::Database.instance.merchants_data.each do |merchant|
        if merchant.id == self.merchant_id
          return merchant
        end
      end
    end

    def items=(input)
      @items = input
    end

    def items
      invoice_items.map do |invoice_item|
        invoice_item.item
      end
    end

    def paid?
      transactions.any?(&:successful?)
    end

    def total
      @total ||= invoice_items.map do |inv_item|
        inv_item.total
      end.inject(:+)
    end

    def successful?
      transactions.any? do |t|
        t.successful?
      end
    end

    def self.create(attributes= {})
      i = Invoice.new(:id           => find_new_invoice_id, 
                      :customer     => attributes[:customer], 
                      :merchant     => attributes[:merchant], 
                      :status       => attributes[:status],
                      :created_at   => Time.now.to_s,
                      :updated_at   => Time.now.to_s,
                      :items        => attributes[:items])
      SalesEngine::InvoiceItem.create_invoice_items(attributes[:id], attributes[:items])
      create_items(attributes[:items])
      SalesEngine::Database.instance.add_invoice(i)
      i
    end

    def self.create_items(items)
      items.each do |item|
        SalesEngine::Item.create(item)
      end
    end
  
    def charge(attributes={})
      SalesEngine::Transaction.create(self.id, attributes)
    end

    def self.find_new_invoice_id
      SalesEngine::Database.instance.invoices_data.size.to_i + 1
    end

  end
end
