module SalesEngine

  class Customer

   attr_accessor :results, :input, :id, :first_name, :last_name, :created_at, :updated_at

    def self.random
      return SalesEngine::Database.instance.customers_data.sample
    end

    class << self
      [:id, :first_name, :last_name, :created_at, :updated_at].each do |attribute|
        define_method "find_by_#{attribute}" do |parameter|
          @input = parameter.downcase
          SalesEngine::Database.instance.customers_data.find do |dataline|
            dataline.send(attribute.to_s).downcase == @input
          end
        end

        define_method "find_all_by_#{attribute}" do |parameter|
          @input = parameter.downcase
          SalesEngine::Database.instance.customers_data.select do |dataline|
            dataline.send(attribute.to_s).downcase == @input
          end
        end 
      end
    end


  end
end