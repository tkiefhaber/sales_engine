module SalesEngine

  class Merchant

    attr_accessor :results, :input, :id, :name, :created_at, :updated_at

    def initialize(attributes = {})
      self.id           = attributes[:id]
      self.name         = attributes[:name]
      self.created_at   = attributes[:created_at]
      self.updated_at   = attributes[:updated_at]
    end

    def self.random
      return SalesEngine::Database.instance.merchants_data.sample
    end

    class << self
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

    def items=(input)
      @items = input
    end

    def items
      @items || SalesEngine::Database.instance.items_data.select do |item_object|
        self.id == item_object.send(:merchant_id)       
      end
    end

    def invoices=(input)
      @invoices = input
    end

    def invoices
      @invoices || SalesEngine::Database.instance.invoices_data.select do |invoice_object|
        self.id == invoice_object.send(:merchant_id)
      end
    end

  end
end