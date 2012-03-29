module SalesEngine

  class Invoice

    attr_accessor :results, :input, :id, :customer_id, 
                  :merchant_id, :status, :created_at, :updated_at

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

    class << self

      [:id, :customer_id, :merchant_id, 
        :status, :created_at, :updated_at].each do |attribute|
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

    def items=(input)
      @items = input
    end

    def invoice_items=(input)
      @invoice_items = input
    end

    def customer=(input)
      @customer = input
    end    

    def transactions
      t = SalesEngine::Database.instance.transactions_data
      @transactions || t.select do |transaction|
        transaction.invoice_id == self.id
      end
    end

    def invoice_items
      ii = SalesEngine::Database.instance.invoice_items_data
      @invoice_items || ii.select do |invoice|
        self.id == invoice.invoice_id
      end
    end

    def customer
      c = SalesEngine::Database.instance.customers_data
      @customer ||= c.each do |customer|
        if customer.id == self.customer_id
          return customer
        end
      end
    end

    def merchant
      m = SalesEngine::Database.instance.merchants_data
      @merchant ||= m.each do |merchant|
        if merchant.id == self.merchant_id
          return merchant
        end
      end
    end

    def items
      @items ||= invoice_items.collect do |invoice_item|
        invoice_item.item
      end
    end

    def paid?
      transactions.any?(&:successful?)
    end

    def unpaid?
      transactions.none?(&:successful?)
    end

    def total
      @total ||= invoice_items.map do |inv_item|
        inv_item.total
      end.inject(:+)
    end

    def self.create(attributes= {})

      SalesEngine::InvoiceItem.create_invoice_items(find_new_invoice_id, 
                                                    attributes[:items])

      i = Invoice.new(:id              => find_new_invoice_id,
                      :customer_id     => attributes[:customer].id,
                      :merchant_id     => attributes[:merchant].id,
                      :status          => attributes[:status],
                      :created_at      => Time.now.to_s,
                      :updated_at      => Time.now.to_s)
                      # :items        => attributes[:items])
      
      SalesEngine::Database.instance.add_invoice(i)
      i
    end
  
    def charge(attributes={})
      SalesEngine::Transaction.create(self.id, attributes)
    end

    def self.find_new_invoice_id
      SalesEngine::Database.instance.invoices_data.size.to_i + 1
    end

  end
end
