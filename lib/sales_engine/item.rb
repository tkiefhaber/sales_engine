module SalesEngine
  
  class Item

    attr_accessor :results, :input, :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

    def initialize(attributes = {})
      self.id                = attributes[:id]
      self.name              = attributes[:name]
      self.description       = attributes[:description]
      self.unit_price        = attributes[:unit_price]
      self.merchant_id       = attributes[:merchant_id]
      self.created_at        = Date.parse(attributes[:created_at])
      self.updated_at        = Date.parse(attributes[:updated_at])
    end

    def self.random
      return SalesEngine::Database.instance.items_data.sample
    end

    class << self
      [:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at].each do |attribute|
        define_method "find_by_#{attribute}" do |parameter|
          @input = parameter.downcase
          SalesEngine::Database.instance.items_data.find do |dataline|
            dataline.send(attribute.to_s).downcase == @input
          end
        end

        define_method "find_all_by_#{attribute}" do |parameter|
          @input = parameter.downcase
          SalesEngine::Database.instance.items_data.select do |dataline|
            dataline.send(attribute.to_s).downcase == @input
          end
        end 
      end
    end

    def invoice_id=(input)
      @invoice_id = input
    end

    def invoice=(input)
      self.invoice_id = input.id
      @invoice = input
    end


    def merchant=(input)
      self.merchant_id = input.id
      @merchant = input
    end

    def merchant
      @merchant || SalesEngine::Database.instance.merchants_data.select do |merchant_object|
        self.merchant_id == merchant_object.send(:id)
      end
    end

    def invoice_items=(input)
      @invoice_items = input
    end

    def invoice_items
      @invoice_items || SalesEngine::Database.instance.invoice_items_data.select do |invoice_item_object|
        self.id == invoice_item_object.send(:item_id)
      end
    end

    def self.most_revenue(x)
      all_items = Database.instance.items_data
      sorted = all_items.sort_by { |item| -item.revenue }
      sorted[0...x]
    end

    def revenue
      @revenue ||= self.invoice_items.inject(0) do |sum, invoice_item|
         sum += invoice_item.quantity.to_i * invoice_item.unit_price.to_i
       end
    end

    def self.most_items(x)
      all_items = Database.instance.items_data
      sorted = all_items.sort_by { |item| -item.items_sold }
      sorted[0...x]
    end

    def items_sold
      @items_sold ||= self.invoice_items.inject(0) do |sum, invoice_item|
        sum += invoice_item.quantity
      end
    end

    def best_day
      days = Hash.new { |hash, key|  hash[key] = 0 }
      self.invoice_items.each do |invoice_item|
        days[invoice_item.invoice.created_at] += invoice_item.quantity.to_i
      end
      days.sort_by {|key, value| -value }.first.first
    end


    # def paid_invoices
    #   @invoices = SalesEngine::Database.instance.invoices_data.select do |invoice|
    #     invoice.paid?
    #   end
    # end


    # def self.most_revenue(x=1)
    #   all_merchants = Database.instance.merchants_data
    #   sorted = all_merchants.sort_by { |merchant| -merchant.revenue }
    #   sorted[0...x]
    # end

    # def revenue(date=nil)
    #   if date 
    #     invoices_by_date(date).inject(0) do |revenue, invoice|
    #       revenue += invoice.invoice_items.inject(0) do |sum, invoice_item|
    #         sum += invoice_item.quantity * invoice_item.unit_price
    #       end
    #     end
    #   else
    #     @revenue ||= self.paid_invoices.inject(0) do |revenue, invoice|
    #       revenue += invoice.invoice_items.inject(0) do |sum, invoice_item|
    #         sum += invoice_item.quantity * invoice_item.unit_price
    #       end
    #     end
    #   end
    # end

  end
end