module SalesEngine
  
  class Item

    attr_accessor :results, :input, :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

    def initialize(attributes = {})
      self.id                = attributes[:id]
      self.name              = attributes[:name]
      self.description       = attributes[:description]
      self.unit_price        = attributes[:unit_price]
      self.merchant_id       = attributes[:merchant_id]
      self.created_at        = attributes[:created_at]
      self.updated_at        = attributes[:updated_at]
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

    def merchant=(input)
      self.merchant_id = input.id
      @merchant = input
    end

    def merchant
      # returns the items for a given instance of merchant
      @merchant || SalesEngine::Database.instance.merchants_data.select do |merchant_object|
        self.merchant_id == merchant_object.send(:id)
      end
    end

    def invoice_items=(input)
      # self.merchant_id = input.id
      @invoice_items = input
    end

    def invoice_items
      puts self.id
      # returns the items for a given instance of merchant
      @invoice_items || SalesEngine::Database.instance.invoice_items_data.select do |invoice_item_object|
        self.id == invoice_item_object.send(:item_id)
      end
    end

  end
end