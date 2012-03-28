module SalesEngine

  class Merchant

    attr_accessor :results, :input, :id, :name, :created_at, :updated_at

    def initialize(attributes = {})
      self.id           = attributes[:id]
      self.name         = attributes[:name]
      self.created_at   = Date.parse(attributes[:created_at])
      self.updated_at   = Date.parse(attributes[:updated_at])
    end

    def items=(input)
      @items = input
    end

    def invoices=(input)
      @invoices = input
    end

    def customers=(input)
      @customers = input
    end

    def self.random
      return SalesEngine::Database.instance.merchants_data.sample
    end

    class << self

      def add_merchant(merchant)
        SalesEngine::Database.instance.merchants_data << merchant
      end

      def clear_merchants
        SalesEngine::Database.instance.merchants_data = []
      end

      [:id, :name, :created_at, :updated_at].each do |attribute|
        define_method "find_by_#{attribute}" do |parameter|
          @input = parameter.downcase
          SalesEngine::Database.instance.merchants_data.find do |dataline|
            dataline.send(attribute.to_s).downcase == @input
          end
        end

        define_method "find_all_by_#{attribute}" do |parameter|
          @input = parameter.downcase
          SalesEngine::Database.instance.merchants_data.select do |dataline|
            dataline.send(attribute.to_s).downcase == @input
          end
        end 
      end
    end

    def invoice_items
      invoices.map do |invoice|
        invoice.invoice_items
      end
    end

    def items
      @items ||= SalesEngine::Database.instance.items_data.select do |item_object|
        self.id == item_object.merchant_id       
      end
    end

    def invoices
      @invoices ||= SalesEngine::Database.instance.invoices_data.select do |invoice_object|
        self.id == invoice_object.send(:merchant_id)
      end
    end

    def customers
      @customers ||= self.invoices.collect do |invoice|
        invoice.customer
      end
    end

    def items_sold
      @items_sold ||= self.paid_invoices.inject(0) do |quantity, invoice|
        quantity += invoice.invoice_items.inject(0) do |sum, invoice_item|
          sum += invoice_item.quantity
        end
      end
    end

    def self.most_items(x=1)
      all_merchants = Database.instance.merchants_data
      sorted = all_merchants.sort_by { |merchant| -merchant.items_sold }
      sorted[0...x]
    end

    def revenue(date=nil)
      if date 
        invoices_by_date(date).collect do |i|
          i.total
        end.inject(:+)
      else
        @revenue ||= paid_invoices.collect do |i|
          i.total
        end.inject(:+)
      end
    end

    def self.most_revenue(x)
      merchants = Database.instance.merchants_data
      @most_revenue ||= merchants.sort_by do |merchant|
        -merchant.revenue
      end[0...x]
    end

    def self.revenue(date)
      all_merchants = Database.instance.merchants_data
      all_merchants.inject(0) do |sum, merchant|
        sum += merchant.revenue(date)
      end
    end

    def paid_invoices
      invoices.select(&:paid?)
    end

    def invoices_by_date(date)
      self.paid_invoices.select do |invoice|
        invoice.created_at == date
      end
    end

    def customers_with_pending_invoices
      customers.select do |customer|
        customer.invoices.collect do |invoice|
          pending = invoice.transactions.select do |transaction|
            not transaction.successful?
          end
          pending.size > 0
        end
      end
    end

    def favorite_customer
      customers_by_transaction.first
    end

    def customers_by_transaction
      customers.sort_by do |customer|
        -customer.invoices_with_successful_transactions.size
      end
    end

    def invoices_with_successful_transactions
      self.invoices.collect do |invoice|
        invoice.successful?
      end
    end

  end
end