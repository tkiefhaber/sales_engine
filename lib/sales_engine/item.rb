module SalesEngine
  class Item

    attr_accessor :results, :input, :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

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

  end
end