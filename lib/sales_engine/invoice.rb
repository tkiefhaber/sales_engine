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

  end

end
