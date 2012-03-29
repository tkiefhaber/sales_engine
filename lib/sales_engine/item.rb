module SalesEngine
  
  class Item

    attr_accessor :results, :input, :id, :name, 
                  :description, :unit_price, :merchant_id, 
                  :created_at, :updated_at

    def initialize(attributes = {})
      self.id             = attributes[:id].to_i
      self.name           = attributes[:name]
      self.description    = attributes[:description]
      self.unit_price     = BigDecimal.new(attributes[:unit_price].to_s)/100
      self.merchant_id    = attributes[:merchant_id].to_i
      self.created_at     = Date.parse(attributes[:created_at].to_s)
      self.updated_at     = Date.parse(attributes[:updated_at].to_s)
    end

    def self.random
      return SalesEngine::Database.instance.items_data.sample
    end

    class << self
      [:id, :name, :description, :unit_price, 
        :merchant_id, :created_at, :updated_at].each do |attribute|
        define_method "find_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.items_data.find do |item|
            item.send(attribute) == parameter
          end
        end

        define_method "find_all_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.items_data.select do |item|
            item.send(attribute) == parameter
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

    def invoice_items=(input)
      @invoice_items = input
    end

    def merchant
      m = SalesEngine::Database.instance.merchants_data
      @merchant || m.find do |merchant|
        if self.merchant_id == merchant.id
          merchant
        end
      end
    end

    def invoice_items
      ii = SalesEngine::Database.instance.invoice_items_data
      @invoice_items || ii.select do |invoice_item|
        self.id == invoice_item.item_id
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
      sum = 0
      @items_sold ||= self.invoice_items.each do |invoice_item|
        if invoice_item.invoice.paid?
          sum += invoice_item.quantity
        end
      end
      sum
    end

    def best_day
      days = Hash.new { |hash, key|  hash[key] = 0 }
      self.invoice_items.each do |invoice_item|
        days[invoice_item.invoice.created_at] += invoice_item.quantity.to_i
      end
      days.sort_by {|key, value| -value }.first.first
    end

  end
end