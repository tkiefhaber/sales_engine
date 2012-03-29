require 'date'
module SalesEngine

  class Merchant

    attr_accessor :results, :input, :id, :name, :created_at, :updated_at

    def initialize(attributes = {})
      self.id           = attributes[:id].to_i
      self.name         = attributes[:name]
      self.created_at   = Date.parse(attributes[:created_at].to_s)
      self.updated_at   = Date.parse(attributes[:updated_at].to_s)
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

      [:id, :name, :created_at, :updated_at].each do |attribute|
        define_method "find_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.merchants_data.find do |merchant|
            merchant.send(attribute) == parameter
          end
        end

        define_method "find_all_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.merchants_data.select do |merchant|
            merchant.send(attribute) == parameter
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
      @items ||= SalesEngine::Database.instance.items_data.select do |item|
        self.id == item.merchant_id       
      end
    end

    def invoices
      inv = SalesEngine::Database.instance.invoices_data
      @invoices ||= inv.select do |invoice|
        self.id == invoice.merchant_id
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
        invoices_by_date(date).inject(0) do |sum, invoice|
          sum += invoice.total
        end
      else
        @revenue ||= paid_invoices.inject(0) do |sum, invoice|
          sum += invoice.total
        end
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
      customers = []
      invoices.each do |invoice|
        if invoice.unpaid?
          customers << invoice.customer
        end
      end
      customers
    end

    def favorite_customer
      customers = Hash.new { |hash, key|  hash[key] = 0 }
      invoices.each do |invoice|
        if invoice.paid?
          customers[invoice.customer] += 1
        end
      end
      customers.sort_by {|key, value| -value }.first.first
    end

    def successful_transactions
      invoices.collect do |invoice|
        invoice.paid?
      end
    end

  end
end